class RecipeRatingsController < ApplicationController
  before_action :find_recipe
  before_action :authenticate_user!

  def update
    user = User.find(params.require(:userId))
    rating = @recipe.ratings.find_or_initialize_by(user_id: user.id, name: user.name)
    authorize! :update, rating

    if params[:value].blank?
      rating.delete
    else
      rating.update! value: params[:value]
    end

    head :ok
  end

private

  def find_recipe
    @recipe = Recipe.find(params.require(:recipe_id))
  end

end
