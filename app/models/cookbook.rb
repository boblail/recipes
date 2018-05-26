class Cookbook < ApplicationRecord

  has_many :users
  has_many :recipes, -> { select("*", '(select avg(value) from ratings where ratings.recipe_id=recipes.id) "average_rating"') }
  has_many :preparations, through: :recipes
  has_many :menu_plans
  belongs_to :current_menu_plan, class_name: "MenuPlan", required: false
  has_many :tags

  after_create :create_first_menu_plan!

private

  def create_first_menu_plan!
    self.current_menu_plan = menu_plans.create!(name: "My First Menu Plan")
    update_column :current_menu_plan_id, current_menu_plan.id
  end

end
