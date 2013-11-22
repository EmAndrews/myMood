require 'logger'
include Util

class AdminController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Admin')
    @messages = MessageTemplate.all
  end

  def new_message
    message_text = params[:message][:text]
    MessageTemplate.create!(:text => message_text)
    flash[:notice] = 'Message added!'
    redirect_to admin_path
  end

end
