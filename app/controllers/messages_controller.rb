class MessagesController < ApplicationController

  def create
    message = Message.new(params[:message])

    if message.save
      render :json => message, :status => :created
    else
      render :json => message.errors, :status => :unprocessable_entity
    end
  end

  def index
    messages = Message.limit(params[:limit])
    render :json => messages
  end
end