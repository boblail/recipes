class Recipe < ApplicationRecord

  belongs_to :cookbook
  belongs_to :created_by, class_name: "User"
  belongs_to :photo, optional: true
  has_many :ratings
  has_and_belongs_to_many :menu_plans
  has_and_belongs_to_many :tags

  after_save :update_search_vector

  validates :name, presence: true, length: { minimum: 5 }
  validates :ingredients, presence: true
  validates :created_by, presence: true
  validates :cookbook, presence: true

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
    ratings.where(user_id: user.id, name: name.chomp).pluck(:value)[0]
  end

  def self.search(query_string)
    config = PgSearch::Configuration.new({against: "plain_text"}, self)
    normalizer = PgSearch::Normalizer.new(config)
    options = { dictionary: "english", tsvector_column: "search_vector" }
    query = PgSearch::Features::TSearch.new(query_string, options, config.columns, self, normalizer)
    where(query.conditions)
  end

  def self.reindex!
    update_all <<-SQL
      search_vector = setweight(to_tsvector('english', name), 'A') ||
                      setweight(to_tsvector('english', ingredients), 'A') ||
                      setweight(to_tsvector('english', coalesce(array_to_string((select array_agg(tags.name) from tags inner join recipes_tags ON recipes_tags.tag_id=tags.id AND recipes_tags.recipe_id=recipes.id), ','),'')), 'A') ||
                      setweight(to_tsvector('english', instructions), 'B')
    SQL
  end

  def self.most_popular_first
    order("coalesce((select avg(value) from ratings where recipe_id=recipes.id), 3) desc")
  end

  def tags=(values)
    tags = cookbook.tags.find_or_create_for(values)
    self.tag_ids = tags.map(&:id)
  end

protected

  def search_vector_should_change?
    (changed & %w{name ingredients instructions}).any?
  end

  def update_search_vector
    self.class.where(id: id).reindex!
  end

end
