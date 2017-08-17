class MenuPlansController < ApplicationController
  before_action :authenticate_user!

  def update
    @menu_plan = MenuPlan.find params[:id]
    @menu_plan.recipe_ids = params.require(:recipeIds)
    render json: {}
  end

end
