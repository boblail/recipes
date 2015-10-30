class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe

    return unless user

    can :manage, Recipe
  end

end
