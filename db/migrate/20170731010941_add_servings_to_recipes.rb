class AddServingsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :servings, :string, null: false, default: ""
  end
end
