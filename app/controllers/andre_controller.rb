require 'logger'
#require_relative 'util'
include Util

class AndreController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Andre')
    puts "Sending Message"
#MessageTemplate.create!(:text => 'This is a message.')
#Util.send_message("+18586833304", "Hi Andre")
    @messages = MessageTemplate.all
  end

  def add_message
    message_text = params[:message_text]
    MessageTemplate.create!(:text => message_text)
    flash[:notice] = 'Message added!'
    redirect_to andre_path
  end

end
