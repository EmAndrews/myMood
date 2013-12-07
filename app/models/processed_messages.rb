class ProcessedMessages < ActiveRecord::Base
	attr_accessible :text, :data, :from_my_mood, :date_processed
	belongs_to :user 
	has_one :category
	
	def self.gen_csv(options = {})
		print "to_csv called"
		CSV.generate(options) do |csv|
		  csv << column_names
		  all.each do |message|
		    csv << message.attributes.values_at(*column_names)
		  end
		end
  end
end

