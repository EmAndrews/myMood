include Util

class MessageSendingJob
  def perform
    Delayed::Worker.logger.debug(">> Running perform")
    @users = User.all
    # This is bad! It should be done better later.
    for user in @users do
      if user.wants_messages_today
        for cat_id in user.subscribed_categories
          cat = Category.find_by_id(cat_id)
          if cat == nil
            user.unsubscribe_from cat_id
            next
          end
          next_message_id = user.subscription["#{cat.id}"][:next_message]
          message_to_send = MessageTemplate.find_by_id(next_message_id)
          #nil check for message_to_send (could have been deleted)
          if message_to_send == nil
            message_to_send = cat.message_templates[0]
          end
          next_seq_num = message_to_send.sequence_number + 1
          next_id = cat.get_message(next_seq_num).id
          if next_id != nil
            user.subscription[cat.id.to_s][:next_message] = next_id
            user.save!
            Util.send_message(Util.convert_to_twilio_phone(user.phone_number), message_to_send.text)
            user.add_sent_message_to_conversation message_to_send
          end
        end
      end
    end
  end



end
