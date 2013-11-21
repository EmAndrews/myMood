class ProcessedMessages < ActiveRecord::Base
	attr_accessible :text

	belongs_to :user 
	has_one :category 
end

