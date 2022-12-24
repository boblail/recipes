module ApplicationHelper

  def recipes_path(*)
    "/recipes"
  end

  def search_placeholder
    PLACEHOLDERS.sample
  end

  def bookmarklet_url
    script = "(function(){window.open('#{new_recipe_url}?url='+encodeURIComponent(window.location))})()"
    "javascript:#{URI.encode_www_form_component(script)}"
  end

  def radio_button(name, value, label, model=nil, options={})
    <<~HTML.html_safe
      <label for="#{name}_#{value}">
        #{radio_button_tag name, value, value == model, options}
        <label for="#{name}_#{value}" class="radio-button"></label>
        #{label}
      </label>
    HTML
  end

  def show_menu_plan?
    @show_menu_plan == true
  end

  PLACEHOLDERS = %w{
    chicken
    salad
    hamburgers
    grill
    tomato
    keto
    chocolate
    cocktail
  }.freeze

end
