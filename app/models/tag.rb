class Tag < ApplicationRecord

  belongs_to :cookbook
  has_and_belongs_to_many :recipes

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9\-]+\z/ }

  after_update :reindex_recipes!
  before_destroy :__cache_recipes
  after_destroy :reindex_cached_recipes!

  def name=(value)
    super Tag.normalize(value)
  end

  def self.find_or_create_for(*names)
    names = names.flatten
    tags = named(names).to_a
    missing_names = names - tags.map(&:name)
    tags.concat create(missing_names.map { |name| { name: name } }) if missing_names.any?
    tags
  end

  def self.named(*names)
    where(name: names.flatten.map(&method(:normalize)).uniq)
  end

  def self.normalize(value)
    value.strip.downcase.gsub(/[^a-z0-9]/, "-").gsub(/\-{2,}/, "-")
  end

  def reindex_recipes!
    recipes.reindex!
  end

private

  def __cache_recipes
    @__cached_recipes = Recipe.where(id: recipe_ids)
  end

  def reindex_cached_recipes!
    @__cached_recipes.reindex!
    remove_instance_variable :@__cached_recipes
  end

end
