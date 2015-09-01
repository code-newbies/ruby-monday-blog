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
    user.present? && (user.author? || user.admin?)
  end

  def update?
    user.present? && (record.author == user || user.admin?)
  end

  def destroy?
    user.present? && (record.author == user || user.admin?)
  end
end
