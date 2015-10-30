class AddSearchToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :search_vector, :tsvector
    add_index :recipes, :search_vector, using: :gin
  end
end
