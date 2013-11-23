include Util

class SmsController < ApplicationController

	def receive_sms
		message = params[:Body]
		from = params[:From]		#phone number of user

		#Look up user w/ phone number, make sure actually in db
		users = User.where(:phone_number => Util.convert_to_database_phone(from))
		
		if users.blank?
			Util.send_message(from, "We don't recognize your number. Please sign up at myMood to start tracking!")
			render nothing: true
			return
		end

		user = users[0]

		#parse message… from start of message, expect to get:
		#optional space, a letter, optional space, number, optional space, optional text
		regex = /^\s*(?<letter>[a-zA-Z]+)\s*(?<rating>\d+)\s*(?<message>.*)/

		data = regex.match(message)

		unless data   #no match, can’t read it
			Util.send_message(from, "We couldn't read that.  Please try again in the form: m5")
			save_nonparseable_message(user, message)
			return
		end
		
		#check message contents, respond to different cases and store data
		handle_readable_sms_from_valid_user(user, from, message, data)
	end

	def handle_readable_sms_from_valid_user(user, from, message, data)
		#from the regex
	  category = data[:letter].downcase
		mood = data[:rating]
		extra = data[:message]
		
		#Make sure the category exists
		cat_id = Category.where(:prefix => category)
		if cat_id.blank?
			Util.send_message(from, "Prefix '"+ category +"' not recognized, please check your response and try again.")
			save_nonparseable_message(user, message)
			return
		end
		
		#make sure user is subscribed to this category
			unless user.subscription[cat_id[0].id]
				Util.send_message(from, "You are not signed up for category '" + category + "', please sign up online if you would like to subscribe.")
				save_nonparseable_message(user, message)
				return
			end
		
		#make sure mood is in range
		if ((mood.to_i() > 10) or (mood.to_i() < 1))
			Util.send_message(from, "We can only accept ratings from 1-10.  Please try again.")
			save_nonparseable_message(user, message)
			return
		end
		
		Util.send_message(from, "You entered " + mood + " for " + cat_id[0].name + ". Thank you!")
		save_message(user, message, mood)
	end
	
	def save_nonparseable_message(user, message)
			save_message(user, message, nil)
		return
	end
	
	def save_message(user, message, data)
		m = ProcessedMessages.new(:text => message)
		m.user_id = user.id
		m.from_my_mood = false
		m.date_processed = Time.now
		m.data = data
		m.save!
		render nothing: true
	end
	
end
