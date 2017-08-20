module ApplicationHelper

  def recipes_path(*)
    "/recipes"
  end

  def bookmarklet_url
    script = "(function(){window.open('#{new_recipe_url}?url='+encodeURIComponent(window.location))})()"
    "javascript:#{URI.encode(script)}"
  end

  def radio_button(name, value, label, model=nil, options={})
    <<~HTML.html_safe
      #{radio_button_tag name, value, value == model, options}
      <label for="#{name}_#{value}" class="radio-button"></label>
      <label for="#{name}_#{value}">#{label}</label>
    HTML
  end

end
