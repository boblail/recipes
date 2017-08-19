require "test_helper"

class RecipeSearchTest < ActiveSupport::TestCase

  context "A new recipe" do
    should "be searchable by its name" do
      recipe = Recipe.create!(new_recipe_attrs(name: "chicken"))
      assert Recipe.search("chicken").exists?
    end

    should "be searchable by its ingredients" do
      Recipe.create!(new_recipe_attrs(ingredients: "dill\nbutter\ncarrots"))
      assert Recipe.search("butter").exists?
    end

    should "be searchable by its instructions" do
      Recipe.create!(new_recipe_attrs(instructions: "broil"))
      assert Recipe.search("broil").exists?
    end

    should "be searchable by its tags" do
      Recipe.create!(new_recipe_attrs(tags: %w{gluten-free}))
      assert Recipe.search("gluten-free").exists?
    end
  end


  context "When a recipe's tag is renamed, it" do
    setup do
      @recipe = Recipe.create!(new_recipe_attrs(tags: %w{gluten-free}))
      @tag = @recipe.tags.first
      @tag.update_attribute :name, "paleo"
    end

    should "no longer be a result for the tag's former name" do
      refute Recipe.search("gluten-free").exists?
    end

    should "be a result for the tag's new name" do
      assert Recipe.search("paleo").exists?
    end
  end


  context "When a recipe's tag is deleted, it" do
    setup do
      @recipe = Recipe.create!(new_recipe_attrs(tags: %w{gluten-free}))
      @tag = @recipe.tags.first
      @tag.destroy
    end

    should "no longer be a result for the tag's former name" do
      refute Recipe.search("gluten-free").exists?
    end
  end


private

  def new_recipe_attrs(attributes={})
    { name: "factory name",
      ingredients: "factory ingredients",
      instructions: "factory instructions",
      cookbook: user.cookbook,
      created_by: user }.merge(attributes)
  end

  def user
    @user ||= users(:test)
  end

end
