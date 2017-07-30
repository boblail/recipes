class User < ActiveRecord::Base

  devise :trackable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    info = access_token.info
    user = User.find_or_initialize_by(email: info.fetch("email"))
    user.name = info.fetch("name")
    user.image_url = info.fetch("image")
    user.save! if user.changed?
    user
  end

  def image_url(options={})
    super() || gravatar_url(options)
  end

  def gravatar_url(options={})
    url = "//www.gravatar.com/avatar/#{Digest::MD5::hexdigest(email)}?r=g&d=retro"
    url << "&s=#{options[:size] * 2}" if options.key?(:size)
    url
  end

  def family_members
    @family_members ||= User.all
  end

end
