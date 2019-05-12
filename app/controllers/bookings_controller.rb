class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :destroy, :update]
  before_action :check_booking_user, only: [:show, :destroy]
  before_action :check_room_user, only: [:room_index, :update]

## Swagger Documentation 
  swagger_controller :bookings, 'Bookings'

  swagger_api :index do
    summary 'Show a list of all bookings belonging to the current user'
  end

  swagger_api :show do
    summary 'Show a specified booking'
    param :path, :id, :integer, "Booking Id"
  end

  swagger_api :create do
    summary 'Create a new booking'
  end

  swagger_api :update do
    summary 'Accept or Decline a booking belonging to a room of the current user'
    param :path, :id, :integer, "Booking Id"
  end

  swagger_api :destroy do
    summary "Cancel an existing booking."
    param :path, :id, :integer, "Booking Id"
  end

  swagger_api :room_index do
    summary "View all bookings on a room belonging to the current user."
  end
#####################################################################################


  ## Show a list of all bookings belonging to the current user
  def index
    @bookings = current_user.bookings.where.not('is_canceled')
  end

  ## Show a specified booking
  def show
  end

  ## Create a new booking 
  def create
    @booking = current_user.bookings.build(booking_params)
    ##No means of handling error for accross pages right now in view so letting it fail as is. 
    @booking.save!
    redirect_to room_booking_path(id: @booking.id, room_id: @booking.room.id), notice: "Room has been booked"
  end

  ## Accept or Decline a booking belonging to a room of the current user
  def update
    if @booking.update(confirmation_params)
      redirect_to room_bookings_path(room_id: @booking.room.id), notice: "Booking confirmation has been set"
    else
      render :index
    end
  end

  ## Cancel an existing booking 
  def destroy
    if @booking.start_date <= Date.today
      flash[:alert] = "Cannot cancel a booking after it has already began."
      render :show
    else
      @booking.is_canceled = true
      @booking.save!
      redirect_to bookings_path, notice: "Booking has been deleted"
    end
  end

  ## View all bookings on a room belonging to the current user
  def room_index
    @bookings = @room.bookings.where.not('is_canceled').order(start_date: :asc)
  end

  ## Helper functions
  private
    ## Specify the allowed parameters for creation and editing of a booking
    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :price, :room_id)
    end

    ## Specify the allowed parameters for creation and editing of a booking
    def confirmation_params
      params.require(:booking).permit(:confirmation_status, :confirmation_message)
    end

    ## Set the given room
    def set_room
      id = params[:room_id]
      if !id
        raise "Invalid Room Id"
      else
        @room = Room.find(id)
        if !@room.is_active
          raise "Invalid Room Id"
        end
      end
    end

    ## Set the given booking
    def set_booking
      id = params[:id] || params[:booking_id]
      if(!id)
        redirect_to bookings_path, notice: "Invalid Booking Id."
      else
        @booking = Booking.find(id)
      end
    end

    ## Check that the user of a booking is the same as current user
    def check_booking_user
      if current_user.id != @booking.user.id
        redirect_to bookings_path, notice: "Cannot view a booking belonging to another user."
      end
    end

    ## Check that the user of a booking's room is the same as current user
    def check_room_user
      set_room
      if current_user.id != @room.user.id
        redirect_to bookings_path, notice: "Cannot Accept/Decline a booking of a room belonging to another user."
      end
    end
end
