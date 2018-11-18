class AddArchivedAtToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :archived_at, :timestamp
  end
end
