include Util

class MessageSendingJob
  def perform
    puts ">> Running perform"
    Util.send_message "+18586921233", "Hello"
    @users = User.all
    for user in @users do
      if user.wants_messages_today
        for cat in user.get_categories
          next_message_id = user.subscription[cat.id][:next_message]
          @message_to_send = Message.find_by_id(next_message_id)
          next_seq_num = @message_to_send.sequence_number + 1
          user.subscription[cat.id][:next_message] = cat.get_message(next_seq_num).id
          Util.send_message(user.phone_number, @messsage_to_send)
          user.add_sent_message_to_conversation @message_to_send
        end
      end
    end
  end
end
