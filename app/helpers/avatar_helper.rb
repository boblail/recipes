module AvatarHelper

  def avatar_for(user, options={})
    return "" unless user

    size = options.fetch(:size, 24)
    "<img class=\"avatar user-#{user.id}\" src=\"#{user.image_url(options)}\" width=\"#{size}\" height=\"#{size}\" alt=\"#{user.name}\" />".html_safe
  end

end
