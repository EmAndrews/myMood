require 'spec_helper'

#http://www.mutuallyhuman.com/blog/2012/04/03/testing-sms-interactions-in-ruby-on-rails/

# Twilio cheat sheet:
#  open_last_text_message_for(phone_number)  <- we want to play with the last thing we sent TO phone_number
#  current_text_message  <- the message we got from the command above
#  current_text_message.should have_body "text we think we sent"  <- what did we try to send?


describe SmsController, :type => :controller do
  
  #our twilio number
  let(:twilio_phone_number) {"+15109964117"}
  # Kim's phone number
  let(:registered_phone_dashes) {"410-402-3113"}
  let(:registered_phone_number) {"+14104023113"}
  # Emily's phone number
  #let(:registered_phone_number2) {"+19724087780"}

  before do
    clear_messages  #no messages sent yet
    user = User.new(:name => "Kim", :phone_number => registered_phone_dashes, :password => "password123", :password_confirmation => "password123", :email => "email@email.com")
    user.save!
  end

  describe 'mood message interactions' do
    before do
    	#send_message(:registered_phone_number, 'Hello! How are you feeling today on a scale of m1-10?')
    end
  
    describe 'recieve mood message from service' do
      it 'should be recorded in users conversation' do
        #user = Users.find_by_phone_number(registered_phone_number)
        
        # Should look up in user's conversation and find 
        # sent text.
      end
    end

    describe 'user responds to mood question correctly' do
      before do
        post :receive_sms, {:From => registered_phone_number, :To => twilio_phone_number, :Body => 'm 10'}
      end

      it 'should be added to the user conversation' do
      	
      end

      it 'should be parsed and added to mood data' do
      	
      end
    end

    describe 'user responds to mood question incorrectly' do
      before do
        post :receive_sms, {:From => registered_phone_number, :To => twilio_phone_number, :Body => 'm blah'}
      end

      it 'should tell me if I texted in something wrong' do
        open_last_text_message_for(registered_phone_number)
        current_text_message.should have_body "We couldn't read that.  Please try again in the form: m5"
        #TODO: match error messages
        # Check that its added to convo
      end

      it 'should be added to conversation ' do
        # Check that incorrect response added to convo
      end
    end      
  end
end

