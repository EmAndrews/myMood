class MessageTemplate < ActiveRecord::Base
	belongs_to :category
  attr_accessible :text, :category
end
