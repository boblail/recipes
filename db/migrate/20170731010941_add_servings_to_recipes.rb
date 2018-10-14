class AddServingsToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :servings, :string, null: false, default: ""
  end
end
