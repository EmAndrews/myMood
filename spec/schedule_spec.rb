require 'spec_helper'
include Util

describe MessageSendingJob do
  before do
    @mood_cat = Category.new(:name => "mood", :prefix => 'm')
    @mood_cat.save!
    @message1 = MessageTemplate.create!(:text => "This is mood text 1.",
                            :category => @mood_cat,
                            :sequence_number => 1)
    @user1 = User.create!(:name => "User1", :subscription => {@mood_cat.id => {:next_message => 0}, -1 => {:next_message => -1}},
              :phone_number => '111-111-1111', :password => "user1_pass",
              :email => 'user1@email.com',
              :availability => {'M' => [], 'Tu' => [], 'W' => [], 'F' => [], 'Su' => []})
    @user2 = User.create!(:name => "User2", :subscription => {@mood_cat.id => {:next_message => 0}, -1 => {:next_message => -1}},
              :phone_number => '222-222-2222', :password => "user2_pass",
              :email => 'user2@email.com',
              :availability => {'M' => [], 'Tu' => [], 'W' => [], 'F' => [], 'Sa' => []})
  end
  
  # @Andre/Alex, I figured out how to set the time to 
  # the day we want:
  # Time.stub!(:now).and_return(Time.mktime(year, month, day))
  # Now when we call Time.now, the time we created will be returned.
  # Bam.
  # 
  # @Emily, NICE!
  
  describe 'perform' do
    before(:each) do
      # This is a Sunday
      Time.stub!(:now).and_return(Time.mktime(2013, 12, 1))
      @job = MessageSendingJob.new
    end
    
#    it 'should iterate through all users' do
#User.should_receive(:all)
#User.stub(:all).and_return([@user1, @user2])
#@job.perform
#end
    
    # In the before block, I set it to Sunday, so user1 should get a message
    it 'should send a message for user1' do
      User.stub(:all).and_return([@user1])
      @user1.should_receive(:wants_messages_today).and_return(true)
      Util.should_receive(:send_message).with('+11111111111', @message1.text)
      @job.perform
    end
    
    # User2 should not get a message because today is sunday
    it 'should not send a message for user2' do
      User.stub(:all).and_return([@user2])
      @user2.should_receive(:wants_messages_today).and_return(false)
      Util.should_not_receive(:send_message)
      @job.perform
    end
  end

  
end
