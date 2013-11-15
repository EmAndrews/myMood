class SmsController < ApplicationController

	def receive_sms
		message = params[:Body]
		from = params[:From]		#phone number of user

		#look up user w/ from

		#parse message… from start of message, expect to get:
		#optional space, a letter, optional space, number, optional space, optional text
		regex = /^\s*(?<letter>[a-zA-Z])\s*(?<rating>\d+)\s*(?<message>.*)/

		data = regex.match(message)  #this part untested

		#send_message(from, message)  #echo!

		unless data   #no match, can’t read it
			send_message(from, "We couldn't read that.  Please try again in the form: m10")
			return
		end

	  category = data[:letter]
		mood = data[:rating]
		extra = data[:message]
		
		send_message(from, "Your mood is " + mood)

	  #store stuff in our database
	end



	def send_message(to, message)
	  sid = 'ACb85e0121426b1e833e86822cc2800cb6'
	  token =  'dc7e939dfe23d90dc37644173b7e7415'
		client = Twilio::REST::Client.new sid, token
		client.account.sms.messages.create(:from => '+15109964117', :to => to, :body => message)
	end
end
