require "open-uri"

class RecipeWebpageParser
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def attributes
    {
      name: recipe.name[0...255],
      ingredients: recipe.ingredients.join("\n"),
      instructions: recipe.instructions,
      servings: recipe.yield.to_s[0...255],
      source: url,
      photo_id: photo&.id
    }
  end

  def recipe_detected?
    !recipe.nil?
  end

  def body
    @body ||= URI.open(url).read
  end

  def photo
    @photo ||= recipe.image_url && Photo.create!(filename: open(recipe.image_url))
  rescue
    nil
  end

private

  def recipe
    @recipe ||= Hangry.parse(body)
  end

end
