require 'spec_helper'
require 'sms_controller'

describe SmsController do
	before do
    clear_messages  #no messages sent yet
    user = User.new(:name => "Kim", :phone_number => registered_phone_dashes, :password => "password123", :password_confirmation => "password123", :email => "email@email.com")
    user.save!
  end
	
	before do
		post :send_message, {:from => '+14104023113', :body => 'hello!'}  
	end

	describe 'recieve mood message from service' do
      it 'should be recorded in users conversation' do
	 		end
	end	

end 
