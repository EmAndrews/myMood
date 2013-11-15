class MessageQueue < ActiveRecord::Base

  has_many :sent_messages

end
