class RoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update]
  before_action :check_room_user, only: [:edit, :update]

  ## Show a list of all rooms belonging to the current user.
  def index
    @rooms = current_user.rooms
  end

  ## Provide model of existing room for editing - Room must belong to current user
  def search
    @rooms = [];
    if(params.has_key?(:city))
      @rooms = Room.select("rooms.*").where.not(id: Room.joins(:bookings).select("rooms.id").where(
        "(bookings.start_date >= ? AND bookings.start_date <= ?)
        OR (bookings.end_date >= ? AND bookings.end_date <= ?)
        OR (bookings.start_date < ? AND bookings.end_date > ?)", 
        params[:start_date], params[:end_date], 
        params[:start_date], params[:end_date],
        params[:start_date], params[:end_date],
        )).where("rooms.city = ?", params[:city]).group("rooms.id")
    end
  end

  ## Show a specified room
  def show
  end

  ## Provide model to build a new room
  def new
    @room = current_user.rooms.build
  end

  ## Create a new room
  def create
    @room = current_user.rooms.build(room_params)
    if @room.valid?
      @room.save!
      redirect_to edit_room_path(@room), notice: "Room has been saved"
    else
      render :new
    end
  end

  ## Provide model of existing room for editing - Room must belong to current user
  def edit
  end

  ## Update an existing room - Room must belong to current user
  def update
    if @room.update(room_params)
      redirect_to edit_room_path(@room), notice: "Room has been saved"
    else
      render :edit
    end
  end

  ## Helper functions
  private
  	## Set the given room
    def set_room
      id = params[:id]
      if(!id)
        redirect_to root_path, notice: "Invalid Room Id"
      end
      @room = Room.find(params[:id])
    end

    ## Specify the allowed parameters for creation and editing of a room
    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodates, :city, :price, :title, :summary, :has_kitchen, :has_shampoo,
       :has_heating, :has_air_conditioning, :has_washer, :has_dryer, :has_wifi, :has_breakfast, :has_indoor_fireplace, :has_hangers,
       :has_iron, :has_hair_dryer, :has_laptop_workspace, :has_tv, :has_crib, :has_high_chair, :has_self_check_in, :has_smoke_detector,
       :has_carbon_monoxide_detector, :has_private_bathroom, :bedrooms, :beds, :bathrooms, :address, :longitude, :latitude, :is_active)
    end

    ## Check that the user of a room is the same as current user for edit and update
    def check_room_user
      if current_user.id != @room.user.id
        redirect_to root_path, notice: "Cannot edit a room belonging to another user."
      end
    end
end

