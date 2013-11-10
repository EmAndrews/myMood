class Schedule < ActiveRecord::Base
 belongs_to :category

  attr_accessor :number, :unit

end
