include Util

class MessageSendingJob
  def perform
    puts "PERFORM"
    Delayed::Worker.logger.debug(">> Running perform")
    @users = User.all
    for user in @users do
      puts ">> Perf for #{user.name}"
      if user.wants_messages_today
        for cat_id in user.subscribed_categories
          cat = Category.find_by_id(cat_id)
          if cat == nil
            puts '>> Nil cat'
            user.subscription.remove cat_id
          else
            next_message_id = user.subscription[cat.id][:next_message]
            @message_to_send = Message.find_by_id(next_message_id)
            next_seq_num = @message_to_send.sequence_number + 1
            next_id = cat.get_message(next_seq_num).id
            if next_id != nil
              user.subscription[cat.id][:next_message] = next_id
              Util.send_message(user.phone_number, @messsage_to_send.text)
              user.add_sent_message_to_conversation @message_to_send
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
