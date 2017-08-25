class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:search_text]
      @searched = true
      @cars = Car.where('lower(name) LIKE lower(?) OR lower(model) LIKE lower(?) OR lower(make) LIKE lower(?) OR lower(location) LIKE lower(?)', "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%")
    elsif params[:end_date]
      #implement
      @searched = true
      @cars = []
      Car.all.each do |car|
        if car.bookings.all? do |booking|
             booking.end_date.to_s < params[:start_date] || booking.start_date.to_s > params[:end_date]
           end
           @cars << car
        end
      end
    else
      @cars = Car.all
      @searched = false
    end
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
    @hash = Gmaps4rails.build_markers(@car) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
      # marker.infowindow render_to_string(partial: "/cars/map_box", locals: { car: car })
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(strong_params)
    @car.user = current_user

    if @car.save
      redirect_to users_cars_path
    else
      render :new
    end
  end

  # Todo Edit Here to implement Car Information Edit!

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(strong_params)
      redirect_to users_cars_path
    else
      render "edit"
    end
  end

  # Todo Edit Here to implement Car Information Destroy!
  def destroy
    car = Car.find(params[:id])
    if car.user_id == current_user.id
      car.destroy
      redirect_to users_cars_path
    else
      # throw pop-up with FU message
      redirect_to users_cars_path
    end
  end

  private

  def strong_params
    params.require(:car).permit(:name, :make, :year, :color, :seats, :location, :transmission, :price, :photo, :photo_cache)
  end
end
