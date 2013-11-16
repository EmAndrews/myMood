class InboundMessage < ActiveRecord::Base

  attr_accessor :received_at

  has_one :message
  belongs_to :conversation

end
