module ApplicationHelper

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

  def metrics_for(recipe)
    <<~HTML.html_safe
    <div class="metrics">
      <table>
        <tr>
          <th>Difficulty</th>
          <td>#{rating recipe.effort, max: 3, class: "effort", glyph: "asterisk"}</td>
        </tr>
        <tr>
          <th>Cost</th>
          <td>#{rating recipe.cost, max: 3, class: "cost", glyph: "usd"}</td>
        </tr>
      </table>
    </div>
    HTML
  end

  def ratings_for(recipe)
    html = '<div class="ratings"><table>'
    current_user.family_members.each do |user|
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

  def bookmarklet_url
    script = "(function(){window.open('#{new_recipe_url}?url='+encodeURIComponent(window.location))})()"
    "javascript:#{URI.encode(script)}"
  end

end
