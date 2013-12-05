class Category < ActiveRecord::Base
  attr_accessible :name, :prefix
  # set messages is this category to be deleted when the category is
  has_many :message_templates, :dependent => :destroy
  has_one :message_sequence

  #has_one :schedule
  #has_one :sequence


  def get_message(seq_num)
    messages = MessageTemplates.find_by_category(self.id)
    if messages == nil or messages.count == 0
      return nil
    end
    if seq_num > messages.count
      seq_num = 1
    end
    messages.each do |m|
      if m.sequence_number == seq_num
        return m
      end
    end
    return nil
  end

end
