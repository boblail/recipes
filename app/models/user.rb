class User < ActiveRecord::Base

  devise :database_authenticatable,
         # :registerable,
         # :recoverable,
         :rememberable,
         :trackable,
         # :confirmable,
         # :lockable,
         # :timeoutable,
         # :omniauthable,
         :validatable

  def family_members
    @family_members ||= User.all
  end

end
