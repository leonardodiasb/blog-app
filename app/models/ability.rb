class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :read, Comment
    can :read, Like

    return unless user.present?

    can :manage, Post, author: user
    can :manage, Comment, author: user
    return unless user.admin?

    can :manage, :all
    # Permission - :manage, :read, :create, :update and :destroy
  end
end
