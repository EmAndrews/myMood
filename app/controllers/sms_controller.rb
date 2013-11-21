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

		#Look up user w/ phone number, make sure actually in db
		if User.where(:phone_number => Util.convert_to_database_phone(from)).blank?
			Util.send_message(from, "We don't recognize your number. Please sign up at myMood to start tracking!")
			render nothing: true
			return
		end

		#parse message… from start of message, expect to get:
		#optional space, a letter, optional space, number, optional space, optional text
		regex = /^\s*(?<letter>[a-zA-Z])\s*(?<rating>\d+)\s*(?<message>.*)/

		data = regex.match(message)

		unless data   #no match, can’t read it
			Util.send_message(from, "We couldn't read that.  Please try again in the form: m5")
			render nothing: true
			return
		end

		#from the regex
	  category = data[:letter]
		mood = (data[:rating]).to_i  #store as int
		extra = data[:message]
		
		#TODO: Validate category and mood
		#Make sure the category exists
		cat_id = Category.where(:prefix => category)
		if cat_id.blank?
			Util.send_message(from, "Prefix '"+ category +"' not recognized, please check your response and try again.")
			render nothing: true
			return
		end
		
		#make sure user is subscribed to this category
		#"You are not signed up for '"+ category + "' tracking, please sign up online if you would like to subscribe."
		
		#make sure mood is in range
		if ((mood > 10) or (mood < 1))
			Util.send_message(from, "We can only accept ratings from 1-10.  Please try again.")
			render nothing: true
			return
		end
		
		Util.send_message(from, "Your mood is " + mood + ". Thank you!")

	  #TODO: store stuff in our database
	  #stuff we have:
	  	#category prefix/id
	  	#mood
	  	#user phone number
	  	#full message, extra notes from message
	  
	  
	  render nothing: true
	end
end
