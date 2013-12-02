require 'spec_helper'
require_relative '../lib/MessageSendingJob'

describe MessageSendingJob do
  before do
    mood_cat = Category.new(:name => "mood", :prefix => 'm')
    mood_cat.save!
    user1 = User.create!(:name => "User1", :subscription => {mood_cat.id => {}}, :phone_number => '111-111-1111', :password => "user1_pass", :email => 'user1@email.com', :availability => {'M' => True, 'Tu' => True, 'W' => True, 'F' => True, 'Sa' => True, 'Su' => False})
    user2 = User.create!(:name => "User2", :subscription => {mood_cat.id => {}}, :phone_number => '222-222-2222', :password => "user2_pass", :email => 'user2@email.com', :availability => {'M' => True, 'Tu' => True, 'W' => True, 'F' => True, 'Sa' => True, 'Su' => False})
  end

end
