module ApplicationHelper

  def recipes_path(*)
    "/recipes"
  end

  def bookmarklet_url
    script = "(function(){window.open('#{new_recipe_url}?url='+encodeURIComponent(window.location))})()"
    "javascript:#{URI.encode(script)}"
  end

end
