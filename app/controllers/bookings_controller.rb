class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
    #This means @bookings = Booking.where("user_id = ?", current_user.id)

    @cars = Car.includes(:bookings).where(bookings: {user_id: current_user.id})
    #There are some other ways to implement the above. I left memo.
    # 1st one(tricky): @cars = @bookings.map(&:car)
    # 2nd one: @cars = []
    #          @cars = @bookings.map do |booking|
    #            booking.car
    #          end
    # 3rd one: @cars = []
    #          @bookings.each do |b|
    #            @cars << Car.where('id = ?', b.car_id).first
    #          end
  end

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id].to_i)
    #recieve @car from cars/:car_id/show
    ## show page has an instance of @car
    #@user = current_user
  end

  def create
    # raise
    @car = Car.find(params[:car_id].to_i)
    @booking = Booking.new(strong_params)
    @booking.user = current_user
    #create Booking
    if @booking.save
      redirect_to car_booking_path(@car.id, @booking.id)
    else
      render 'cars/show'
    end
  end

  def show
    @car = Car.find(params[:car_id].to_i)
    if params[:id]
      @booking = Booking.find(params[:id].to_i)
    else
      @booking = Booking.new
    end
  end


  def update
  end

  def destroy
    booking = Booking.find(params[:id])
    if booking.user == current_user
      booking.destroy
      redirect_to bookings_index_path
    else
      # throw pop-up with FU message
      redirect_to root_path
    end
  end


  private

  def strong_params
    params.require(:booking).permit(:start_date, :end_date, :car_id)
  end
end
