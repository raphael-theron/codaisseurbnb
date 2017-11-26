class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
  @booking = current_user.bookings.new(booking_params.merge(room_id: params[:room_id]))
  @booking.set_total_price
  @booking.save

  redirect_to @booking.room, notice: "Thank you for booking!"
end

  private

  def get_total_price(booking_params)
    checkin, checkout = get_dates(booking_params)

    total_days = (checkout - checkin).to_i
    booking_params[:price].to_i * total_days
  end

  def get_dates(booking_params)
    checkin  =  Date.new(booking_params["starts_at(1i)"].to_i,
                         booking_params["starts_at(2i)"].to_i,
                         booking_params["starts_at(3i)"].to_i)

    checkout =  Date.new(booking_params["ends_at(1i)"].to_i,
                         booking_params["ends_at(2i)"].to_i,
                         booking_params["ends_at(3i)"].to_i)

    return checkin, checkout
  end

  def booking_params
     params.require(:booking).permit(:starts_at, :ends_at)
   end
end
