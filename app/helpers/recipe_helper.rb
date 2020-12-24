module RecipeHelper

  def source_of(recipe)
    <<~HTML.html_safe unless recipe.source.blank?
      <p class="recipe-source">#{format_source(recipe.source)}</p>
    HTML
  end

  def photo_of(recipe, options={})
    wrap_in_link = options.delete :link
    options = options.reverse_merge(class: "photo")
    placeholder = options.delete(:placeholder)
    html = if recipe.photo
      image_tag(recipe.photo.url, options)
    elsif placeholder
      image_tag("//via.placeholder.com/#{placeholder.join("x")}", options)
    else
      '<span class="photo photo-placeholder"></span>'.html_safe
    end
    html = link_to(recipe) { html } if wrap_in_link
    html
  end

  def last_preparation_of(recipe, link_to: nil)
    return "Made <em>Never</em>".html_safe if recipe.new_recipe?
    return "Made some time ago" unless recipe.last_prepared_on

    time_frame = "<b>#{days_ago_in_words recipe.last_prepared_on}</b>"
    time_frame = link_to(time_frame.html_safe, link_to) if link_to
    "Made #{time_frame}".html_safe
  end

  def describe_user(user)
    "#{avatar_for user, size: 16} <b>#{user.name}</b>".html_safe
  end

  def format_source(source)
    begin
      link_to URI(source).host, source
    rescue URI::InvalidURIError
      h source
    end
  end

  def tags_for(recipe)
    <<~HTML.html_safe if recipe.tags.any?
      <span class="recipe-tags">#{tags(recipe.tags)}</span>
    HTML
  end

  def tags(tags)
    tags.each_with_object("") do |tag, html|
      html << "<span class=\"label\">#{h tag.name}</span> "
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

  def average_rating_for(recipe)
    rating recipe.yumminess, class: "yumminess", glyph: "heart"
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
