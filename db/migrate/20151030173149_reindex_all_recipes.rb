class ReindexAllRecipes < ActiveRecord::Migration[4.2]
  def up
    Recipe.reindex!
  end
end
