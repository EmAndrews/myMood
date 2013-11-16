class OutboundMessage < ActiveRecord::Base

  has_one :message
  belongs_to :conversation

  attr_accessor :date_to_send, :sent_at

end
