class AddSearchToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :search_vector, :tsvector
    add_index :recipes, :search_vector, using: :gin
  end
end
