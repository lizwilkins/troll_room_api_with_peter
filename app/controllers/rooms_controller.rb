class RoomsController < ApplicationController

  def create
    room = Room.new(params[:room])

    if room.save
      render :json => room, :status => :created
    else
      render :json => room.errors, :status => :unprocessable_entity
    end
  end

  def index
    rooms = Room.limit(params[:limit])
    render :json => rooms
  end

  def list_messages
    puts "hi"
    p params
    p messages = Message.where(:room_id == params['room_id']).limit(params[:limit])
    render :json => messages
  end

  def show
    room = Room.find(params[:id])
    render :json => room
  end
end