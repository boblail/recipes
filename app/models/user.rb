class User < ActiveRecord::Base

  devise :trackable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    info = access_token.info
    User.create_with({
      name: info.fetch("name"),
    }).find_or_create_by(email: info.fetch("email"))
  end

  def family_members
    @family_members ||= User.all
  end

end
