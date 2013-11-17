require 'spec_helper'

describe Mailer do 
  
  before(:each) do
    @fake = double("Mailer")
    @fake_user1 = User.new
    @fake_user2 = User.new
    @message1 = Message.new
    @message2 = Message.new
    @mailer = Mailer.new
    @nil_user = nil
  end
  it 'should start the mailer job' do
    enqueue_mailer_delayed_job.should == true
  end
  
  describe 'now_to_day' do
    it 'should return an int' do
      now_to_day(Time.now).should be_a_kind_of Integer
    end
    it 'should return 1 or a power of 2' do
      (now_to_day(Time.now) % 2).should == 1 or 0
    end
  end

  describe 'daily_cron' do
    it 'should iterate over every user' do
      User.should_receive(:where).and_return([@fake_user1, @fake_user2])
      @fake.should_receive(:prep_messages).with(@fake_user1)
      @fake.should_receive(:prep_messages).with(@fake_user2)
      @mailer.daily_cron
    end
    it 'should error on nil user' do
      User.should_receive(:where).and_return([@nil_user])
      @fake.should_receive(:prep_messages).with(@nil_user)
      logger.should_receive(:debug)
      @mailer.prep_messages(@nil_user)
    end
  end

  describe 'prep_messages' do
    it 'should process the messages queue' do
      @fake_user1.should_receive(:message_queue).and_return([@message1, @message2])
      @message1.should_receive(:date_to_send).and_return(0)
      @message2.should_receive(:date_to_send).and_return(0)
      @fake.should_receive(:enqueue_next_message).with(@message1, @fake_user1)
      @fake.should_receive(:enqueue_next_message).with(@message2, @fake_user1)
      @fake.should_receive(:send_message_to_user).with(@message1, @fake_user1)
      @fake_user1.message_queue.should_receive(:delete).with(@message1)
      @mailer.prep_messages(@fake_user1)
    end
  end

  describe 'enqueue_next_message' do
    it 'should get the next sequence number' do
      @fake_user1.should_receive(:user_states).and_return({:seq_num => 3})
      @message1.should_receive(:category).and_return(@category1)
      @category1.should_receive(:get_next_message_and_num).with(3).and_return(@next_message, 4)
      @fake_user1.message_queue.should_receive(:add)

      @mailer.enqueue_next_message(@message1, @fake_user1)
    end
  end

end
