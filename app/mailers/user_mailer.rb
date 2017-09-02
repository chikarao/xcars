class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
    # en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Thanks for signing-up! Welcome to the world of X-cars."
    mail(to: @user.email, subject: 'Welcome to Xcars!')
  end

  def car_creation_confirmation(user, car_name)
    @user = user
    @car_name = car_name
    # byebug
    @message = "Thanks for your listing your #{@car_name}!"
    mail(to: @user.email, subject: 'Thanks for your listing!')
  end

def booking_creation_confirmation(start_date, end_date, car_user, car_name, booking_user)
    @car_user = car_user
    @car_name = car_name
    @start_date = start_date
    @end_date = end_date
    @booking_user = booking_user

    # byebug
    @message = "Thanks for booking the #{car_name}! Your booking is from #{@start_date} to #{@end_date}."
    mail(to: @booking_user.email, subject: "Thanks for your booking the #{car_name}!")
  end

def booking_creation_lister_confirmation(start_date, end_date, car_user, car_name, booking_user)
    @car_user = car_user
    @car_name = car_name
    @start_date = start_date
    @end_date = end_date
    @booking_user = booking_user

    # byebug
    @message = "Your #{@car_name} has been booked! The booking is from #{@start_date} to #{@end_date}."
    mail(to: @car_user.email, subject: "Your #{@car_name} has been booked!")
  end


end
