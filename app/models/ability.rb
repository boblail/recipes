class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe

    return unless user

    can :manage, Recipe, cookbook_id: user.cookbook_id

    # You can edit your own ratings as well as the ratings of any
    # user in your cookbook who has never signed in
    can :update, Rating do |rating|
      rating.user_id == user.id ||
      (rating.user.sign_in_count.zero? && rating.user.cookbook_id == user.cookbook_id)
    end
  end

end
