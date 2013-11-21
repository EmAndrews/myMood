class Category < ActiveRecord::Base
  attr_accessible :name, :prefix
  has_many :message_templates
  has_one :message_sequence

  #has_one :schedule
  #has_one :sequence

end
