class Category < ActiveRecord::Base
  attr_accessible :name, :prefix
  # set messages is this category to be deleted when the category is
  has_many :message_templates, :dependent => :destroy
  has_one :message_sequence

  #has_one :schedule
  #has_one :sequence

end
