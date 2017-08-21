class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:my_recipes, :edit, :new, :create, :update, :destroy]

  def all_recipes
    @recipes = Recipe.order(:name).preload(:photo, :tags).without_copies
    @recipes = @recipes.search params[:q] unless params[:q].blank?
  end

  def my_recipes
    @filter = params.fetch(:s, "a")
    @recipes = current_user.cookbook.recipes.most_popular_first.preload(:photo, :tags)
    @recipes = @recipes.where(new_recipe: false) if @filter == "m"
    @recipes = @recipes.where(new_recipe: true) if @filter == "n"
    @recipes = @recipes.search params[:q] unless params[:q].blank?
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def new
    @recipe = current_user.cookbook.recipes.build
    authorize! :create, @recipe

    if params[:url]
      parser = RecipeWebpageParser.new(url: params[:url])
      if parser.recipe_detected?
        @recipe.attributes = parser.attributes
      else
        flash.now[:notice] = "Couldn't find a recipe in that URL"
      end
    end

    if params[:recipe_id]
      recipe = Recipe.find(params[:recipe_id])
      @recipe.copy_of! recipe
    end

    @tags = Recipe.pluck(:tags).flatten.uniq
  end

  def edit
    @tags = Recipe.pluck(:tags).flatten.uniq
    authorize! :update, @recipe
  end

  def create
    @recipe = current_user.cookbook.recipes.build(created_by: current_user)
    authorize! :create, @recipe

    @recipe.attributes = recipe_params
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
      .permit(:name, :ingredients, :instructions, :source, :tags, :servings, :photo_id, :copy_of_id, :new_recipe)
    attributes.merge(tags: attributes[:tags].to_s.split(","))
  end

end
