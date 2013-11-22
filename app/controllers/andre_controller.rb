require 'logger'
#require_relative 'util'
include Util

class AndreController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Andre')
    puts "Sending Message"
#MessageTemplate.create!(:text => 'This is a message.')
    Util.send_message("+18586921233", "Hi Andre")
    @messages = MessageTemplate.all
    @categories = Category.all
  end


  def new_something
    commit = params[:commit]
    if commit == "Add Message"
      new_message params[:message]
    elsif commit == "Add Category"
      new_category params[:category]
    else
      redirect_to andre_path
    end
  end

  def new_category category
    cat_name = category[:name]
    Category.create!(:name => cat_name)
    flash[:notice] = "Category '#{cat_name}' created!"
    redirect_to andre_path
  end

  def new_message message
    message_text = message[:text]
    MessageTemplate.create!(:text => message[:text], :category => Category.find_by_name(message[:category]))
    flash[:notice] = "Message '#{message_text}' added with category '#{message[:category]}'!"
    redirect_to andre_path
  end

end
