class RoomsController < ApplicationController 
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  
  def index 
    @rooms = Room.all
  end 

  def show 
    @room = Room.find(params[:id])
  end 

  private
  def set_room
    @room = Room.find(params[:id])
  end
end 