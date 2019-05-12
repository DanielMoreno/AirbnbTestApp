class RoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy, :publish, :contract_agreement]
  before_action :check_room_user, only: [:edit, :update, :destroy, :publish, :contract_agreement]

## Swagger Documentation 
  swagger_controller :rooms, 'Rooms'

  swagger_api :index do
    summary 'Show a list of all rooms belonging to the current user'
  end

  swagger_api :search do
    summary 'Search for a room to book given a set of search parameters'
    param :path, :id, :string, :optional, "City"
    param :path, :id, :date, :optional, "Start Date"
    param :path, :id, :date, :optional, "End Date"
  end

  swagger_api :show do
    summary 'Show a specific room'
    param :path, :id, :integer, "Room Id"
  end

  swagger_api :new do
    summary 'Provide model to build a new room'
  end

  swagger_api :create do
    summary 'Create a new room'
  end

  swagger_api :edit do
    summary 'Provide model of existing room for editing - Room must belong to current user'
    param :path, :id, :integer, "Room Id"
  end

  swagger_api :update do
    summary 'Update an existing room - Room must belong to current user'
    param :path, :id, :integer, "Room Id"
  end

  swagger_api :destroy do
    summary "Destroy an existing room - sets a existing room to inactive. Room cannot have any active bookings."
    param :path, :id, :integer, "Room Id"
  end

  swagger_api :publish do
    summary 'Publish or unpublish a room'
    param :path, :id, :integer, "Room Id"
  end

  swagger_api :contract_agreement do
    summary 'Update the Contract Agreement on a room'
    param :path, :id, :integer, "Room Id"
  end
#####################################################################################

  ## Show a list of all rooms belonging to the current user
  def index
    @rooms = current_user.rooms.where('is_active')
  end

  ## Search for a room to book given a set of search parameters
  def search
    @rooms = [];
    if(params.has_key?(:city))
      @rooms = Room.select("rooms.*").where.not(id: Room.joins(:bookings).select("rooms.id").where(
        "((bookings.start_date >= ? AND bookings.start_date <= ?)
        OR (bookings.end_date >= ? AND bookings.end_date <= ?)
        OR (bookings.start_date < ? AND bookings.end_date > ?))
        AND bookings.confirmation_status = 'accepted' AND NOT bookings.is_canceled", 
        params[:start_date], params[:end_date], 
        params[:start_date], params[:end_date],
        params[:start_date], params[:end_date],)).
        where("rooms.city LIKE (?)
          AND rooms.is_active AND rooms.is_published", params[:city]).
        group("rooms.id")
    end
  end

  ## Show a specific room
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

  ## Destroy an existing room - sets a existing room to inactive. Room cannot have any active bookings.
  def destroy
    today = Date.today
    bookings = @room.bookings.where("(start_date >= ? OR end_date >= ?) 
      AND bookings.confirmation_status = 'accepted' 
      AND NOT is_canceled", today, today)
    if(bookings.any?)
      render :edit
      flash[:alert] = "Cannot inactive a room with existing bookings. Cancel existing bookings and retry this action."
    else
      @room.is_active = false;
      @room.save!
      redirect_to rooms_path, notice: "Room has been deleted"
    end
  end

  ## Publish or unpublish a room 
  def publish
    if @room.update(room_publish)
      redirect_to edit_room_path(@room), notice: "Room has been updated"
    else
      render :edit
    end
  end


  ## Update the Contract Agreement on a room
  def contract_agreement
    if @room.update(room_contract_agreement)
      redirect_to edit_room_path(@room), notice: "Agreement has been updated"
    else
      render :edit
    end
  end

  ## Helper functions
  private
  	## Set the given room
    def set_room
      id = params[:id] || params[:room_id]
      if !id
        redirect_to rooms_path, notice: "Invalid Room Id"
      else
        @room = Room.find(id)
        if !@room.is_active
          redirect_to rooms_path, notice: "Invalid Room Id"
        end
      end
    end

    ## Specify the allowed parameters for creation and editing of a room
    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodates, :city, :price, :title, :summary, :has_kitchen, :has_shampoo,
       :has_heating, :has_air_conditioning, :has_washer, :has_dryer, :has_wifi, :has_breakfast, :has_indoor_fireplace, :has_hangers,
       :has_iron, :has_hair_dryer, :has_laptop_workspace, :has_tv, :has_crib, :has_high_chair, :has_self_check_in, :has_smoke_detector,
       :has_carbon_monoxide_detector, :has_private_bathroom, :bedrooms, :beds, :bathrooms, :address, :longitude, :latitude)
    end

    ## Specify the allowed parameters for Publishing a room
    def room_publish
      params.require(:room).permit(:is_published)
    end

    ## Specify the allowed parameters for Contract Agreement
    def room_contract_agreement
      params.require(:room).permit(:contract_agreement)
    end

    ## Check that the user of a room is the same as current user for edit and update
    def check_room_user
      if current_user.id != @room.user.id
        redirect_to rooms_path, notice: "Cannot edit a room belonging to another user."
      end
    end
end

