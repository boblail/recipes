class LinkMenuPlansAndRecipes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :menu_plans, :recipes do |t|
      t.index [:menu_plan_id, :recipe_id], unique: true
    end
  end
end
