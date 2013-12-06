class ProcessedMessages < ActiveRecord::Base
	attr_accessible :text, :data, :from_my_mood, :date_processed
	belongs_to :user 
	has_one :category 
	
	def self.to_csv(options = {})
		print "testing"
		CSV.generate(options) do |csv|
		  csv << column_names
		  all.each do |product|
		    csv << product.attributes.values_at(*column_names)
		  end
		end
	end
  
end

