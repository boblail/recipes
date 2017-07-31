require "open-uri"

class RecipeWebpageParser
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def attributes
    {
      name: recipe.name,
      ingredients: recipe.ingredients.join("\n"),
      instructions: recipe.instructions,
      servings: recipe.yield,
      source: url
    }
  end

  def recipe_detected?
    !(recipe.name.blank? || recipe.ingredients.nil? || recipe.instructions.blank?)
  end

  def body
    @body ||= open(url).read
  end

private

  def recipe
    @recipe ||= Hangry.parse(body)
  end

end
