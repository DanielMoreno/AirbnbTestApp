class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show]
  before_action :check_booking_user, only: [:show]

  ## Show a list of all bookings belonging to the current user.
  def index
    @bookings = current_user.bookings
  end

  ## Show a specified booking
  def show
  end

  ## Create a new booking 
  def create
    @booking = current_user.bookings.build(booking_params)
    ## Note, this should be done in the model once I can figure out how to overwrite that setter...
    if(@booking.price && @booking.end_date && @booking.start_date )
      @booking.total = @booking.price * (@booking.end_date - @booking.start_date)
    end
    ##No means of handling error for accross pages right now in view so letting it fail as is. 
    @booking.save!
    redirect_to room_booking_path(id: @booking.id, room_id: @booking.room.id), notice: "Room has been booked"
  end

  ## Helper functions
  private
    ## Specify the allowed parameters for creation and editing of a booking
    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :price, :room_id)
    end

    ## Set the given booking
    def set_booking
      id = params[:id]
      if(!id)
        redirect_to root_path, notice: "Invalid Booking Id"
      end
      @booking = Booking.find(params[:id])
    end

    ## Check that the user of a booking is the same as current user
    def check_booking_user
      if current_user.id != @booking.user.id
        redirect_to root_path, notice: "Cannot view a booking belonging to another user."
      end
    end
end
