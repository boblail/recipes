require "test_helper"

class RecipeTest < ActiveSupport::TestCase

  context "Assigning #copy_of" do
    setup do
      @recipe = create(:recipe, source: "SOURCE", photo_id: 9)
      @copy = Recipe.copy(@recipe)
    end

    should "make the current recipe a copy of another" do
      assert_equal @recipe.id, @copy.copy_of_id
    end

    should "copy the original's attributes" do
      assert_equal @recipe.name, @copy.name, "Expected the copy to have the original's name"
      assert_equal @recipe.instructions, @copy.instructions, "Expected the copy to have the original's instructions"
      assert_equal @recipe.ingredients, @copy.ingredients, "Expected the copy to have the original's ingredients"
      assert_equal @recipe.source, @copy.source, "Expected the copy to have the original's source"
      assert_equal @recipe.photo_id, @copy.photo_id, "Expected the copy to have the original's photo_id"
    end

    should "not copy the original's owner" do
      refute_equal @recipe.created_by_id, @copy.created_by_id, "Expected the copy not to have a created_by_id"
      refute_equal @recipe.cookbook_id, @copy.cookbook_id, "Expected the copy not to have a cookbook_id"
    end
  end

  context "#parsed_ingredients" do
    setup do
      @recipe = create(:recipe)
    end

    should "return Ingreedy parsed ingredients" do
      assert_kind_of Ingreedy::Parser::Result, @recipe.parsed_ingredients.first
    end
  end
end
