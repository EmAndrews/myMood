require 'spec_helper'
require 'sms_controller'

describe SmsController do
	include SmsSpec::Helpers
	let(:twilio_number) {"+16502674928"}
	let(:kim_phone_dashes) {"410-402-3113"}  #for registering
	let(:kim_phone) {"+14104023113"}	#for twilio sending
	let(:unknown_phone) {"+12223334444"}  #NOT a registered user, but we might want a validated number here

	before do
    clear_messages  #no messages sent yet
    mood_cat = Category.new(:name => "mood", :prefix => 'm')
    mood_cat.save!
    sleep_cat = Category.new(:name => "sleep", :prefix => 's')
    sleep_cat.save!
    user = User.new(:name => "Kim", :subscription => {'a' => 1}, :phone_number => kim_phone_dashes, :password => "password123", :password_confirmation => "password123", :email => "email@email.com")
    user.save!
  end
	
	before do
		Util.send_message('+14104023113', "Hello!  How are you feeling today, on a scale of m1-m10?")  #this works now, thanks andre!
	end

	describe 'recieve mood message from service: ' do
		it 'should be sent to the user' do
			open_last_text_message_for kim_phone
			current_text_message.should have_body "Hello!  How are you feeling today, on a scale of m1-m10?"
	 	end
    it 'should be recorded in users conversation' do
      #TODO: find "Hello!  How are you feeling today, on a scale of m1-m10?" from twilio_number in conversation
	 	end
	end
	
	describe 'user responds to service: ' do
	  before do
	  	clear_messages
	  end
		it 'should handle correct replies' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm7'}
			
		  open_last_text_message_for kim_phone
			current_text_message.should have_body "Hello!  How are you feeling today, on a scale of m1-m10?" #don't send anything!
			
			#TODO: find "m7" from kim_phone in conversation
		end
		
		it 'should handle correct replies (flexible)' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'M   7 happy'}
			
		  open_last_text_message_for kim_phone
			current_text_message.should have_body "Hello!  How are you feeling today, on a scale of m1-m10?" #don't send anything!
			
			#TODO: find "M   7 happy" from kim_phone in conversation
		end
		
		it 'should handle incorrect replies' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'cookies!'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We couldn't read that.  Please try again in the form: m5"
			
			#TODO: find "We couldn't read that.  Please try again in the form: m5" from kim_phone in conversation
		end
		
		it 'should not panic for unknown numbers' do
			post :receive_sms, {:From => unknown_phone, :To => twilio_number, :Body => 'm7'}
			
			open_last_text_message_for unknown_phone
			current_text_message.should have_body "We don't recognize your number. Please sign up at myMood to start tracking!"
		end
		
		it "should tell the user if it can't find the category" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'f7'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "Prefix 'f' not recognized, please check your response and try again."
			
			#TODO: find in conversation
		end
		
		it "should tell the user if they're not signed up for a category" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 's7'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "You are not signed up for 'sleep' tracking, please sign up online if you would like to track your sleep."
			
			#TODO: find in conversation
		end
		
		#tell user, or auto-adjust to be inbounds?
		it "should tell the user if their mood is out of range (high)" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm77'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We can only accept ratings from 1-10.  Please try again."
			
			#TODO: find in conversation
		end
		
		it "should tell the user if their mood is out of range (zero)" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm0'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We can only accept ratings from 1-10.  Please try again."
			
			#TODO: find in conversation
		end
	end
end









