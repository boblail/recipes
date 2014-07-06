class RecipeRatingsController < ApplicationController
  before_action :find_recipe
  before_action :authenticate_user!

  def update
    rating = @recipe.ratings.find_or_initialize_by(user_id: current_user.id, name: params[:name].chomp)
    if params[:value].blank?
      rating.delete
    else
      rating.value = params[:value]
      rating.save
    end
    head :ok
  end

private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

end
