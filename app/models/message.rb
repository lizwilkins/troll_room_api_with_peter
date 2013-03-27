class Message < ActiveRecord::Base

  attr_accessible :name, :message

  validates :name, :message, :presence => true

  default_scope limit(20)



end