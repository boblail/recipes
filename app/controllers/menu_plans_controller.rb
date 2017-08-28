class MenuPlansController < ApplicationController
  before_action :authenticate_user!

  def update
    @menu_plan = MenuPlan.find params[:id]
    @menu_plan.recipe_ids = params.fetch(:recipeIds)
    render json: {}
  end

  def create
    new_menu_plan = current_user.cookbook.menu_plans.create(menu_plan_params)
    if new_menu_plan.save
      render json: { id: new_menu_plan.id, name: new_menu_plan.name }, status: :created
    end
  end

  private

  def menu_plan_params
    params.require(:menu_plan).permit(:name)
  end
end
