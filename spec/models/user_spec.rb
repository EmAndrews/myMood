require 'spec_helper'

describe User do
	before(:each) do 	
		user = User.new
	  user.name = "Sargun"
		user.phone_number = "510-709-5301"
		user.email = "sargun.kaur@berkeley.edu"
		user.password = "cs169test123"
    user.availability = {'m' => 'true', 't' => 'false', 'w' => 'true', 'th' => 'true', 'f' => 'false', 's' => 'false', 'su' => 'true'}
		user.subscription = {1 => {"next_message" => 1, "send_at" => "20131127 18:23:00"}, 2 => {"next_message" => 5, "send_at" => "20131129 08:41:00"}}
		user.save!
  end
	
	it 'should find a user' do
		u = User.where(:phone_number => '510-709-5301')

		u = u[0]

		u.availability.should eq({'m' => 'true', 't' => 'false', 'w' => 'true', 'th' => 'true', 'f' => 'false', 's' => 'false', 'su' => 'true'})
	end
 	
	it { should validate_presence_of :name }

	#it {should serialize(:subscription).as(Hash)}
	#it {should serialize(:availability).as(Hash)}

	#it "deserializes the hash" do 
		#User.reload.availability.should eq({'m' => 'true', 't' => 'false', 'w' => 'true', 'th' => 'true', 'f' => 'false', 's' => 'false', 'su' => 'true'})
	#end
	
	
	it "should show the user's availability"
		
	it "should show all the user's subscriptions"
end
