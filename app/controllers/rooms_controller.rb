require "opentok"
class RoomsController < ApplicationController 
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  
  def index 
    @rooms = Room.all
  end 

  def new 
    @room = Room.new
  end 

  def create 
    @room = Room.new(room_params)  
    if @room.save 
      redirect_to room_path(@room) 
    else 
      render :new
    end 
  end 

  def show 
    # @room = Room.find(params[:id]) 
    # generate opentok token 
    opentok = OpenTok::OpenTok.new(ENV["api_key"], ENV["secret_key"]) # opentok client 
    # session = opentok.create_session # new opentok session
    @token = opentok.generate_token(@room.vonage_session_id) # generate token 
  end 

  def edit 
    @room = Room.find(params[:id])
  end 

  def update 
    @room = Room.find(params[:id]) 
    if @room.update(room_params) 
      redirect_to room_path(@room) 
    else 
      render :edit 
    end 
  end 

  def destroy 
    @room = Room.find(params[:id]) 
    @room.delete 
    redirect_to root_path
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params 
    params.require(:room).permit(:name, :description, :vonage_session_id)
  end
end 