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
    messTemp = MessageTemplate.new(:category => mood_cat, :sequence_number => 0)
    messTemp.save!
    sleep_cat = Category.new(:name => "sleep", :prefix => 's')
    sleep_cat.save!
    user = User.new(:name => "Kim", :subscription => {mood_cat.id => {}}, :phone_number => kim_phone_dashes, :password => "password123", :password_confirmation => "password123", :email => "email@email.com")
    user.save!
  end
	
	before do
		clear_messages
		Util.send_message('+14104023113', "Hello!  How are you feeling today, on a scale of m1-m10?")  #this works now, thanks andre!
	end

	describe 'recieve mood message from service: ' do
		it 'should be sent to the user' do
			open_last_text_message_for kim_phone
			current_text_message.should have_body "Hello!  How are you feeling today, on a scale of m1-m10?"
	 	end
	end
	
	describe 'user responds to service: ' do
	  before do
	  	clear_messages
	  end
		it 'should handle correct replies' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm7'}
			
		  open_last_text_message_for kim_phone
			current_text_message.should have_body "You entered 7 for mood. Thank you!"
			
			#check if messages are in db
			query = ProcessedMessages.where(:from_my_mood => false, :text => 'm7')
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query = query.where(:data => "7")
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "You entered 7 for mood. Thank you!")
			query.blank?.should be false
		end
		
		it 'should handle correct replies (flexible)' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'M   7 happy'}
			
		  open_last_text_message_for kim_phone
			current_text_message.should have_body "You entered 7 for mood. Thank you!"
			
			#check if messages are in db
			query = ProcessedMessages.where(:from_my_mood => false, :text => 'M   7 happy')
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query = query.where(:data => '7')
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "You entered 7 for mood. Thank you!")
			query.blank?.should be false
		end
		
		it 'should handle incorrect replies' do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'cookies!'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We couldn't read that.  Please try again in the form: m5"
			
			query = ProcessedMessages.where(:from_my_mood => false, :text => "cookies!")
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "We couldn't read that.  Please try again in the form: m5")
			query.blank?.should be false
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
			
			query = ProcessedMessages.where(:from_my_mood => false, :text => "f7")
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "Prefix 'f' not recognized, please check your response and try again.")
			query.blank?.should be false
		end
		
		it "should tell the user if they're not signed up for a category" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 's7'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "You are not signed up for category 's', please sign up online if you would like to subscribe."
			
			query = ProcessedMessages.where(:from_my_mood => false, :text => "s7")
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "You are not signed up for category 's', please sign up online if you would like to subscribe.")
			query.blank?.should be false
		end
		
		#tell user, don't record mood
		it "should tell the user if their mood is out of range (high)" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm77'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We can only accept ratings from 1-10.  Please try again."
			
			query = ProcessedMessages.where(:from_my_mood => false, :text => "m77")
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "We can only accept ratings from 1-10.  Please try again.")
			query.blank?.should be false
		end
		
		it "should tell the user if their mood is out of range (zero)" do
			post :receive_sms, {:From => kim_phone, :To => twilio_number, :Body => 'm0'}
			
			open_last_text_message_for kim_phone
			current_text_message.should have_body "We can only accept ratings from 1-10.  Please try again."
			
			query = ProcessedMessages.where(:from_my_mood => false, :text => "m0")
			query = query.where(:user_id => User.where(:phone_number => kim_phone_dashes)[0].id)
			query.blank?.should be false
			query = ProcessedMessages.where(:from_my_mood => true, :text => "We can only accept ratings from 1-10.  Please try again.")
			query.blank?.should be false
		end
	end
end









