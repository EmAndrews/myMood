require_relative '../app/Util.rb'

class HandleMessagesJob
  def perform
    puts "HandleJobSent"
    #Util.send_message "+18586921233", "HI ME"
  end
end
