class RecipeWebpageParser
  attr_reader :url

  BROWSER_USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36'.freeze

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
    # We pretend to be a browser because some websites (e.g. www.thekitchn.com) respond with
    # a 403 if you have a non-browser-looking User-Agent.
    @body ||= Faraday.get(url, {}, { 'User-Agent' => BROWSER_USER_AGENT }).body
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
