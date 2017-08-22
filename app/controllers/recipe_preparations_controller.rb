class RecipePreparationsController < ApplicationController
  before_action :find_recipe
  before_action :authenticate_user!

  def create
    preparation = @recipe.preparations.build(params.permit(:prepared_on, :comments))
    preparation.prepared_by = current_user
    preparation.save!
    redirect_to recipe_url(@recipe)
  end

private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

end
