class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy]
  load_and_authorize_resource

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end



private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    attributes = params
      .require(:recipe)
      .permit(:name, :instructions, :ingredients, :tags, :effort, :cost, :healthiness, :bob, :rachel)
    attributes.merge(tags: attributes[:tags].to_s.split(","))
  end

end
