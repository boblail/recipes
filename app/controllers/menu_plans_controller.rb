class MenuPlansController < ApplicationController
  before_action :authenticate_user!

  def update
    @menu_plan = MenuPlan.find params[:id]
    @menu_plan.recipe_ids = params.fetch(:recipeIds)
    render json: {}
  end

  def shopping_list
    @menu_plan = current_user.current_menu_plan
  end

end
