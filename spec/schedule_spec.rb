require 'spec_helper'
require_relative '../lib/MessageSendingJob'

describe MessageSendingJob do
  before do
    mood_cat = Category.new(:name => "mood", :prefix => 'm')
    mood_cat.save!
    @user1 = User.create!(:name => "User1", :subscription => {mood_cat.id => {}}, :phone_number => '111-111-1111', :password => "user1_pass", :email => 'user1@email.com', :availability => {'M' => 1, 'Tu' => 1, 'W' => 1, 'F' => 1, 'Sa' => 0, 'Su' => 1})
    @user2 = User.create!(:name => "User2", :subscription => {mood_cat.id => {}}, :phone_number => '222-222-2222', :password => "user2_pass", :email => 'user2@email.com', :availability => {'M' => 1, 'Tu' => 1, 'W' => 1, 'F' => 1, 'Sa' => 1, 'Su' => 0})
  end
  
  # @Andre/Alex, I figured out how to set the time to 
  # the day we want:
  # Time.stub!(:now).and_return(Time.mktime(year, month, day))
  # Now when we call Time.now, the time we created will be returned.
  # Bam.
  
  describe 'perform' do
    before do
      # This is a Sunday
      Time.stub!(:now).and_return(Time.mktime(2013, 12, 1))
    end
    
    it 'should iterate through all users' do
        User.should_receive(:where).and_return([@user1, @user2])
        p Time.now
    end
    
    # In the before block, I set it to Sunday, so user1 should get a message
    it 'should enque a message for user1' do
    end
    
    # User2 should not get a message because today is sunday
    it 'should not enque a message for user2' do
    end
  end
  
end
