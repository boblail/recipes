class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:my_recipes, :edit, :new, :create, :update, :destroy]

  def all_recipes
    @recipes = Recipe.order(:name)
    @recipes = @recipes.search params[:q] unless params[:q].blank?
  end

  def my_recipes
    @recipes = current_user.cookbook.recipes.most_popular_first
    @recipes = @recipes.search params[:q] unless params[:q].blank?
  end

  def show
  end

  def new
    @recipe = Recipe.new
    if params[:url]
      parser = RecipeWebpageParser.new(url: params[:url])
      if parser.recipe_detected?
        @recipe.attributes = parser.attributes
      else
        flash.now[:notice] = "Couldn't find a recipe in that URL"
      end
    end
    @tags = Recipe.pluck(:tags).flatten.uniq
    authorize! :create, @recipe
  end

  def edit
    @tags = Recipe.pluck(:tags).flatten.uniq
    authorize! :update, @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    authorize! :create, @recipe

    @recipe.created_by = current_user
    @recipe.cookbook = current_user.cookbook
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @recipe

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to my_recipes_url, notice: 'Recipe was successfully destroyed.'
  end



private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    attributes = params
      .require(:recipe)
      .permit(:name, :ingredients, :instructions, :source, :tags, :servings)
    attributes.merge(tags: attributes[:tags].to_s.split(","))
  end

end
