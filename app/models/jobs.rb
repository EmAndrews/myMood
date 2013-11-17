# Takes in Time.now and returns a weekday
def now_to_day now
  return 1 << now.wday
end

# Daily job to queue messages for users
def daily_cron
  today = now_to_day(Time.now)
  today_users = User.where("schedule_preference.week & :today == 1", today: today)
  today_users.find_each do |user|
    begin
      prep_messages user
    rescue
      logger.debug('Nil user to prep_messages.')
    end
  end
end

def prep_messages(user)
  if user == nil 
    raise 'Nil user in prep_messages'
  end
  # Check user message queue and send/enqueue messages accordingly
#valid_messages = user.message_queue.where("time_to_send <= :now", now: Time.now)  
  user.message_queue.each do |message|
    if message.date_to_send <= Time.now
      enqueue_next_message message, user
      # Do async?
      send_message_to_user message, user
      user.message_queue.delete message
    end
  end
end

def enqueue_next_message message, user
  logger.debug(">> ENQUEUE NEXT :D")
  # user_state is a hash per category
  user_state = user.user_states[message.category]
  message, next_seq_num =
          message.category.sequence.get_next_message_and_num (user_state[seq_num])
  user_state[seq_num] = next_seq_num

  user.message_queue.add message
end


def send_message_to_user message, user
  logger.debug(">> SEND MESSAGE!: WRITE ME! :D")
  logger.debug(">> Sending message #{message} to user #{user}.")
  # PUT TWILIO STUFF HERE
end

