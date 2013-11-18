require 'logger'
#require_relative 'util'
include Util

class AndreController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Andre')
    puts "Sending Message"
    Util.send_message("+18586833304", "Hi Andre")

  end

end
