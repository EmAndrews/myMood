module Util
	#pass in "2223334444" or "222-333-4444" or "(222) 333-4444" and get back "+12223334444"
	def self.convert_to_twilio_phone (number)
		phone_regex = /\(*(?<start>\d{3})\)*-*\s*(?<middle>\d{3})-*\s*(?<end>\d{4})$/
		data = phone_regex.match(number)
		
		newNumber = "+1" + data[:start] + data[:middle] + data[:end]
		
		return newNumber
	end

	#pass "+12223334444" or "2223334444" and get back "222-333-4444"
	def self.convert_to_database_phone (number)
		phone_regex = /(?<start>\d{3})(?<middle>\d{3})(?<end>\d{4})$/
		data = phone_regex.match(number)
		
		newNumber = data[:start] + "-" + data[:middle] + "-" + data[:end]
		
		return newNumber
	end

	def self.send_message(to, message)
    #puts ">>Util>> Sending message #{message} to #{to}"
	  sid = 'ACb85e0121426b1e833e86822cc2800cb6'
	  token =  'dc7e939dfe23d90dc37644173b7e7415'
	  
	  user = User.where(:phone_number => self.convert_to_database_phone(to))
	  unless user.blank?
			m = ProcessedMessages.new(:text => message)
	  	m.user_id = user[0].id
			m.from_my_mood = true
			m.date_processed = Time.now
			m.save!
		end
	  
		client = Twilio::REST::Client.new sid, token
		client.account.sms.messages.create(:from => '+15109964117', :to => to, :body => message)
	end

  def self.week_day_prefix_map
    return {1 => "M", 2 => "Tu", 3 => "W", 4 => "Th", 5 => "F", 6 => "Sa", 0 => "Su"}
  end


end
