class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe

    return unless user

    can :manage, Recipe, cookbook_id: user.cookbook_id
  end

end
