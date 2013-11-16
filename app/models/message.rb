class Message < ActiveRecord::Base
  attr_accessible :text
  belongs_to :category
  has_one :response_type
end
