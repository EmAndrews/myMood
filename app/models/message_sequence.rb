class MessageSequence < ActiveRecord::Base
  belongs_to :category
  serialize(:sequence, Hash)
  attr_accessor :sequence
end
