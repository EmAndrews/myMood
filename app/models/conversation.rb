class Conversation < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :messages
  belongs_to :user
end
