class Message < ActiveRecord::Base

  attr_accessible :name, :message, :room_id

  validates :name, :message, :room_id, :presence => true

end
