class Category < ActiveRecord::Base
  attr_accessible :name

  has_one :schedule
  has_one :sequence

end
