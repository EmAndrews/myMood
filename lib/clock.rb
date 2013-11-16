require 'clockwork'
require_relative '../app/Util.rb'
#require_relative '../app/controllers/sms_controller.rb'
include Clockwork
include Twilio


handler do |job|
  puts "Running #{job}"
end

every(1.minute, 'frequent.job') do 
  Util.send_message "+18586921233", "HI ME"
end

#every(3.minutes, 'less.frequent.job')
#every(1.hour, 'hourly.job')

#every(1.day, 'midnight.job', :at => '00:00')
