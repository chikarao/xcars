class UserPolicy::CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # def index

  #   return true
  # end
end
