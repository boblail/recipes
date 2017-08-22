class Preparation < ApplicationRecord

  belongs_to :recipe
  belongs_to :prepared_by, class_name: "User"

  validates :prepared_on, presence: true

  after_save :update_last_made_on_on_recipe
  after_create :unflag_recipe_as_new
  after_destroy :update_last_made_on_on_recipe

private

  def update_last_made_on_on_recipe
    last_prepared = recipe.preparations.first
    recipe.update_column :last_prepared_on, last_prepared&.prepared_on
  end

  def unflag_recipe_as_new
    recipe.update_column :new_recipe, false
  end

end
