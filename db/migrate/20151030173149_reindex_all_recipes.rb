class ReindexAllRecipes < ActiveRecord::Migration
  def up
    Recipe.reindex!
  end
end
