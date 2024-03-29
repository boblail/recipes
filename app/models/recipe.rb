class Recipe < ApplicationRecord

  belongs_to :cookbook
  belongs_to :created_by, class_name: "User"
  belongs_to :photo, optional: true
  belongs_to :copy_of, class_name: "Recipe", optional: true
  has_many :ratings
  has_many :preparations, -> { order(prepared_on: :desc) }
  has_and_belongs_to_many :menu_plans
  has_and_belongs_to_many :tags

  after_save :update_search_vector

  validates :name, presence: true, length: { minimum: 5 }
  validates :ingredients, presence: true
  validates :created_by, presence: true
  validates :cookbook, presence: true

  class << self
    def search(query_string)
      config = PgSearch::Configuration.new({against: "plain_text"}, self)
      normalizer = PgSearch::Normalizer.new(config)
      options = { dictionary: "english", tsvector_column: "search_vector" }
      query = PgSearch::Features::TSearch.new(query_string, options, config.columns, self, normalizer)
      where(query.conditions)
    end

    def reindex!
      update_all <<-SQL
        search_vector = setweight(to_tsvector('english', name), 'A') ||
                        setweight(to_tsvector('english', ingredients), 'A') ||
                        setweight(to_tsvector('english', coalesce(array_to_string((select array_agg(tags.name) from tags inner join recipes_tags ON recipes_tags.tag_id=tags.id AND recipes_tags.recipe_id=recipes.id), ','),'')), 'A') ||
                        setweight(to_tsvector('english', instructions), 'B')
      SQL
    end

    def most_popular_first
      reorder("coalesce((select avg(value) from ratings where recipe_id=recipes.id), 3) desc")
    end

    def made_most_recently_first
      reorder("(select max(prepared_on) from preparations where recipe_id=recipes.id) desc nulls last")
    end

    def tried
      where(new_recipe: false)
    end

    def untried
      where(new_recipe: true)
    end

    def newest_first
      reorder(created_at: :desc)
    end

    def sorted_alphabetically
      reorder(name: :asc)
    end

    def favorites
      where("(select avg(value) from ratings where recipe_id=recipes.id) >= 3")
    end

    def unrated_by(user)
      tried.where("not exists (select 1 from ratings where recipe_id=recipes.id and user_id=#{user.id})")
    end

    def without_copies
      where(copy_of_id: nil)
    end

    def copy(recipe)
      Recipe.new.tap do |copy|
        copy.copy_of! recipe
      end
    end

    def unarchived
      unscope(where: :archived_at).where(archived_at: nil)
    end

    def archived
      unscope(where: :archived_at).where.not(archived_at: nil)
    end
  end

  def yumminess(user=nil)
    _ratings = ratings
    if user
      _ratings = _ratings.where(user_id: user.id)
    elsif has_attribute?(:average_rating)
      return read_attribute(:average_rating)
    end
    _ratings.pluck(:value).avg
  end

  def rating_for(user, name=user.name)
    ratings.find_or_initialize_by(user_id: user.id, name: name.chomp)
  end

  def tags=(values)
    tags = cookbook.tags.find_or_create_for(values)
    self.tag_ids = tags.map(&:id)
  end

  def copy_of!(recipe)
    self.copy_of = recipe
    self.attributes = recipe.attributes.slice(
      "name",
      "ingredients",
      "instructions",
      "servings",
      "source",
      "photo_id")
  end

  def parsed_ingredients
    ingredients.split(/\n/).map do |ingredient|
      begin
        Ingreedy.parse(ingredient)
      rescue Ingreedy::ParseFailed
        Ingreedy::Parser::Result.new(nil, nil, nil, nil, ingredient, ingredient)
      end
    end
  end

  def destroy
    preparations.exists? ? archive : super
  end

  def archive
    touch :archived_at
  end

  def archived?
    archived_at.present?
  end

protected

  def search_vector_should_change?
    (changed & %w{name ingredients instructions}).any?
  end

  def update_search_vector
    self.class.where(id: id).reindex!
  end

end
