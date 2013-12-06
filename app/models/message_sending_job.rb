include Util

class MessageSendingJob
  def perform
    puts "PERFORM"
    Delayed::Worker.logger.debug(">> Running perform")
    @users = User.all
    # This is bad! It should be done better later.
    for user in @users do
      puts ">> Perf for #{user.name}"
      if user.wants_messages_today
        puts ">>> User wants messages today: #{user.subscription}"
        for cat_id in user.subscribed_categories
          cat = Category.find_by_id(cat_id)
          if cat == nil
            puts '>> Nil cat'
            user.subscription.remove cat_id
            user.save!
          else
            puts ">>> Processing category: #{cat.name}"
            next_message_id = user.subscription["#{cat.id}"][:next_message]
            @message_to_send = MessageTemplate.find_by_id(next_message_id)
            #TODO nil check for message_to_send (could have been deleted)
            if @message_to_send == nil
              @message_to_send = cat.message_templates[0]
            end
            puts ">>> > Message to send: #{@message_to_send.text}"
            next_seq_num = @message_to_send.sequence_number + 1
            next_id = cat.get_message(next_seq_num).id
            if next_id != nil
              user.subscription[cat.id.to_s][:next_message] = next_id
              user.save!
              puts ">>> > SENDING MESSAGE!!! :)"
              Util.send_message(Util.convert_to_twilio_phone(user.phone_number), @message_to_send.text)
              puts ">>> > SENT MESSAGE!!! :)"
              user.add_sent_message_to_conversation @message_to_send
              puts ">>> > Updated Conversation)"
            else
              puts ">> Next id nil"
            end
          end
        end
      else
        puts ">>> User doesn't want messages today."
        puts ">>> #{user.availability}"
      end
      
    end
  end

  def after(job)
    # do something
    puts "AFTER"
    Delayed::Worker.logger.debug(">> Running after")
  end
end
