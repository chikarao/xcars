class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:search_text]
      @searched = true
      @cars = Car.where('lower(name) LIKE lower(?) OR lower(model) LIKE lower(?) OR lower(make) LIKE lower(?) OR lower(location) LIKE lower(?)', "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%")

      policy_scope(Car).order(created_at: :desc)


    elsif params[:end_date]
      #implement
      @searched = true
      @cars = []
      Car.all.each do |car|
        if car.bookings.all? do |booking|
             booking.end_date.to_s < params[:start_date] || booking.start_date.to_s > params[:end_date]
           end
           @cars << car

           policy_scope(Car).order(created_at: :desc)
        end
      end
    else
      @cars = Car.all

      policy_scope(Car).order(created_at: :desc)

      @searched = false
    end

  end

  def show
    @car = Car.find(params[:id])

    authorize @car

    @booking = Booking.new
    @hash = Gmaps4rails.build_markers(@car) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
      # marker.infowindow render_to_string(partial: "/cars/map_box", locals: { car: car })
    end

  end

  def new
    @car = Car.new

    authorize @car
  end

  def create
    @car = Car.new(strong_params)

    authorize @car

    @car.user = current_user


    if @car.save
      UserMailer.car_creation_confirmation(@car.user, @car.name).deliver_now
      redirect_to users_cars_path
    else
      render :new
    end
  end

  # Todo Edit Here to implement Car Information Edit!

  def edit
    @car = Car.find(params[:id])

    if current_user.admin == true
      authorize @car
    end


    authorize @car
  end

  def update
    @car = Car.find(params[:id])


    if current_user.admin == true
      authorize @car
    end


    if @car.update(strong_params)

    authorize @car

      redirect_to users_cars_path
    else
      render "edit"
    end
  end

  # Todo Edit Here to implement Car Information Destroy!
  def destroy
    @car = Car.find(params[:id])

    authorize @car

    if @car.user_id == current_user.id
      @car.destroy
      redirect_to users_cars_path
    elsif current_user.admin == true
      @car.destroy
      redirect_to cars_path
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
