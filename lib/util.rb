module Util

  def self.test
    puts 'UTIL TESTING'
  end
  
	#pass in "2223334444" or "222-333-4444" or "(222) 333-4444" and get back "+12223334444"
	def self.convert_phone (number)
		phone_regex = /^\(*(?<start>\d{3})\)*-*\s*(?<middle>\d{3})-*\s*(?<end>\d{4})/
		data = phone_regex.match(number)
		
		newNumber = "+1" + data[:start] + data[:middle] + data[:end]
		
		return newNumber
	end


	def self.send_message(to, message)
    puts ">>Util>> Sending message #{message} to #{to}"
	  sid = 'ACb85e0121426b1e833e86822cc2800cb6'
	  token =  'dc7e939dfe23d90dc37644173b7e7415'
		client = Twilio::REST::Client.new sid, token
		client.account.sms.messages.create(:from => '+15109964117', :to => to, :body => message)
	end
end
