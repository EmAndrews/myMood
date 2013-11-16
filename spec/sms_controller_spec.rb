require 'spec_helper'

describe SmsController do
  #include SmsSpec::Helpers
  let(:twilio_phone_number) {"+15109964117"}
  # Kim's phone number
  let(:registered_phone_number) {"+14104023113"}
  # Emily's phone number
  let(:registered_phone_number2) {"+19724087780"}

  before do
    user = User.new(:name => "Kim", :phone_number => registered_phone_number, :password => "password123", :password_confirmation => "password123", :email => "email@email.com")
    user.save!
  end

  describe 'mood message interactions' do
    before do
      post :send_sms, {:To => registered_phone_number, :From => twilio_phone_number, :Body => 'Hello! How are you feeling today on a scale of 1-10?'}
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
        #current_text_message.should have_body "Sorry, we can't read that message.   "
        #TODO: match error messages
        # Check that its added to convo
      end

      it 'should be added to conversation ' do
        # Check that incorrect response added to convo
      end
    end      
  end
end

