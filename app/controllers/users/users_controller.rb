class UsersController < ApplicationController
  def index
    @cars = Car.where("user_id = ?", current_id)
    # @cars = policy_scope(Car).order(created_at: :desc)

    authorize @cars
  end
end
