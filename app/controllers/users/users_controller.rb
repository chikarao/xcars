class UsersController < ApplicationController
  def index
    @Cars = Car.where("user_id = ?", current_id)
  end
end
