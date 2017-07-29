# http://schema.org/Recipe
# used by rachaelray.com, pinchofyum.com
class RecipeMicroformatPresenter
  attr_reader :recipe

  def self.to_json(recipe)
    MultiJson.dump(new(recipe))
  end

  def initialize(recipe)
    @recipe = recipe
  end

  def as_json(*)
    # a lot more metadata is available via this microformat
    # like `cookTime`, `author`, `suitableForDiet`
    # see http://schema.org/Recipe
    {
      "@context" => "http://schema.org",
      "@type" => "Recipe",
      "name" => recipe.name,
      "recipeIngredient": recipe.ingredients.split(/\n/),
      "recipeInstructions" => recipe.instructions
    }
  end

end
