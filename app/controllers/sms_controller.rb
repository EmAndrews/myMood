include Util

class SmsController < ApplicationController

	def receive_sms
		message = params[:Body]
		from = params[:From]		#phone number of user
		
		# Parameters:
		#{"AccountSid"=>"ACb85e0121426b1e833e86822cc2800cb6", "MessageSid"=>"SMa5c0ef07038d1f2ce2fcf2c97f2d5227", 
		#"Body"=>"M7", "ToZip"=>"94555", "ToCity"=>"FREMONT", "FromState"=>"MD", "ToState"=>"CA", 
		#"SmsSid"=>"SMa5c0ef07038d1f2ce2fcf2c97f2d5227", "To"=>"+15109964117", "ToCountry"=>"US", "FromCountry"=>"US",
		#"SmsMessageSid"=>"SMa5c0ef07038d1f2ce2fcf2c97f2d5227", "ApiVersion"=>"2010-04-01", "FromCity"=>"BALTIMORE", 
		#"SmsStatus"=>"received", "NumMedia"=>"0", "From"=>"+14104023113", "FromZip"=>"21228"}
		
		#send_message(from, message)  #echo

		#TODO: look up user w/ from, make sure actually in db

		#parse message… from start of message, expect to get:
		#optional space, a letter, optional space, number, optional space, optional text
		regex = /^\s*(?<letter>[a-zA-Z])\s*(?<rating>\d+)\s*(?<message>.*)/

		data = regex.match(message)

		unless data   #no match, can’t read it
			Util.send_message(from, "We couldn't read that.  Please try again in the form: m5")
			return
		end

		#from the regex
	  category = data[:letter]
		mood = data[:rating]
		extra = data[:message]
		
		#TODO: Validate category and mood
		
		Util.send_message(from, "Your mood is " + mood)

	  #TODO: store stuff in our database
	end


=begin
	def send_message(to, message)
	  sid = 'ACb85e0121426b1e833e86822cc2800cb6'
	  token =  'dc7e939dfe23d90dc37644173b7e7415'
		client = Twilio::REST::Client.new sid, token
		client.account.sms.messages.create(:from => '+15109964117', :to => to, :body => message)
	end
=end
end
