class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # def index
  #   return true
  # end

  def edit?
    return true
  end

  def update?
    return true
  end

  def create?
    return true
  end

  def destroy?
    return true
  end
end
