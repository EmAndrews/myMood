Class MessageSequence << ActiveRecord::Base
  belongs_to :category
  attr_accessor :sequence
  serialize :sequence, Hash
end
