require 'spec_helper'
require_relative '../lib/MessageSendingJob'

describe MessageSendingJob do
  before do
    mood_cat = Category.new(:name => "mood", :prefix => 'm')
    mood_cat.save!
    @user1 = User.create!(:name => "User1", :subscription => {mood_cat.id => {}}, :phone_number => '111-111-1111', :password => "user1_pass", :email => 'user1@email.com', :availability => {'M' => 1, 'Tu' => 1, 'W' => 1, 'F' => 1, 'Sa' => 0, 'Su' => 1})
    @user2 = User.create!(:name => "User2", :subscription => {mood_cat.id => {}}, :phone_number => '222-222-2222', :password => "user2_pass", :email => 'user2@email.com', :availability => {'M' => 1, 'Tu' => 1, 'W' => 1, 'F' => 1, 'Sa' => 1, 'Su' => 0})
  end

  describe 'perform' do
    it 'should iterate through all users' do
        User.should_receive(:where).and_return([@user1, @user2])
    end
    
    it 'should enque a message for user1 if today is not saturday' do
    end
    
    it 'should enque a message for user2 if today is not sunday' do
    end
  end
  
end
