class ProcessedMessages < ActiveRecord::Base
	attr_accessible :text, :data, :from_my_mood, :date_processed
	belongs_to :user 
	has_one :category 
end

