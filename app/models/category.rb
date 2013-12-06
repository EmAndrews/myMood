class Category < ActiveRecord::Base
  attr_accessible :name, :prefix
  # set messages is this category to be deleted when the category is
  has_many :message_templates, :dependent => :destroy
  has_one :message_sequence

  #has_one :schedule
  #has_one :sequence


  def get_message(seq_num)
    messages = self.message_templates
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

  def update_seqs_by_removing(message)
    self.message_templates.each do |m|
      if m.sequence_number > message.sequence_number
        puts "category>> Updating message: #{m.text}, #{m.sequence_number}"
        m.sequence_number -= 1
        m.save!
      end
    end
  end

end
