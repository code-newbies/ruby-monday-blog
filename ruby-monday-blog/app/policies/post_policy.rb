class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # TODO: implement different scopes if published or unpublished
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.author? || user.admin?
  end

  def update?
    record.author == user || user.admin?
  end

  def destroy?
    record.author == user || user.admin?
  end
end
