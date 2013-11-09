class Schedule < ActiveRecord::Base
  belongs_to Category

  attr_accessor :number, :unit

end
