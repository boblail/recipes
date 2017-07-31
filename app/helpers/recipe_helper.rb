module RecipeHelper

  def source_of(recipe)
    <<~HTML.html_safe unless recipe.source.blank?
      <div class="recipe-source">#{format_source(recipe.source)}</div>
    HTML
  end

  def format_source(source)
    if source =~ /:\/\//
      link_to source, source
    else
      h source
    end
  end

  def tags(tags)
    tags.each_with_object("") do |tag, html|
      html << "<span class=\"label label-info\">#{html_escape tag}</span> "
    end.html_safe
  end

  def rating(value, options={})
    max = options.fetch(:max, 5)
    glyph = options.fetch(:glyph, "star")
    width = value * 100.0 / max if value
    css = "rating-#{options.fetch(:class)}" if options.key?(:class)

    html = "<span class=\"rating #{css} rating-#{value.to_i}\"><span class=\"rating-range\">"
    max.times do
      html << "<span class=\"fa fa-#{glyph}\"></span>"
    end
    if width
      html << "</span><span class=\"rating-value\" style=\"width: #{width}%\">"
      max.times do
        html << "<span class=\"fa fa-#{glyph}\"></span>"
      end
    end
    html << "</span></span>"

    html.html_safe
  end

  def ratings_for(recipe)
    html = '<div class="ratings"><table>'
    current_user.cookbook.users.each do |user|
      if user == current_user
        html << <<~HTML
          <tr>
            <th>#{user.name}</th>
            <td class="rating-yumminess"><form action="#{recipe_url(recipe)}"><input class="rating" data-clearable="Clear" data-max="5" data-min="1" type="number" name="#{user.name}" value="#{recipe.rating_for(user)}" /></form></td>
          </tr>
        HTML
      else
        html << <<~HTML
          <tr>
            <th>#{user.name}</th>
            <td>#{rating recipe.yumminess(user), class: "yumminess", glyph: "heart"}</td>
          </tr>
        HTML
      end
    end
    html << "</table></div>"
    html.html_safe
  end

  def snippet(recipe)
    recipe.ingredients.to_s.split(/\n/).map(&:chomp).join(", ") # [0..100]
  end

  def microformat(recipe)
    <<~HTML.html_safe
      <script type="application/ld+json">
        #{RecipeMicroformatPresenter.to_json(recipe)}
      </script>
    HTML
  end

end
