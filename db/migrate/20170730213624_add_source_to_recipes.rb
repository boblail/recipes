class AddSourceToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :source, :string
  end
end
