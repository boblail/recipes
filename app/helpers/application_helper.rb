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

    html = "<span class=\"rating\"><span class=\"rating-range\">"
    max.times do |i|
      html << "<span class=\"glyphicon glyphicon-#{glyph}\"></span>"
    end
    if width
      html << "</span><span class=\"rating-value\" style=\"width: #{width}%\">"
      max.times do |i|
        html << "<span class=\"glyphicon glyphicon-#{glyph}\"></span>"
      end
    end
    html << "</span></span>"

    html.html_safe
  end

  def ratings_for(recipe)
    <<-HTML.html_safe
    <div class="ratings">
      <table>
        <tr>
          <th>Difficulty</th>
          <th>Cost</th>
          #{"<th>Yumminess</th>" if current_user}
        </tr>
        <tr>
          <td>#{rating recipe.effort, max: 3, glyph: "asterisk"}</td>
          <td>#{rating recipe.cost, max: 3, glyph: "usd"}</td>
          #{"<td>#{rating recipe.yumminess(current_user)}</td>" if current_user}
      </table>
    </div>
    HTML
  end

  def snippet(recipe)
    recipe.ingredients.to_s.split(/\n/).map(&:chomp).join(", ")[0..100]
  end

end
