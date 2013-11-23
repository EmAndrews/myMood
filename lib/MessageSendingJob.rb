include Util

class MessageSendingJob
  def perform
    puts ">> Running perform"
    Util.send_message "+18586921233", "Hello"
  end
end
