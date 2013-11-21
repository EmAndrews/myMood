class ProcessedMessages < ActiveRecord::Base
	attr_accessible :text
	attr_accessor :category	

	belongs_to :user 
	has_one :category 
end

