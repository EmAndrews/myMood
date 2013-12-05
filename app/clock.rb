require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'
include Clockwork

every(30.seconds, 'messages.send') do
  Delayed::Job.enqueue MessageSendingJob.new
  puts ">> Clock is enqueing"
end
