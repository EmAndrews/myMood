require 'logger'
include Util

class AdminController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Admin')
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
      redirect_to admin_path
    end
  end

  def new_category category
    cat_name = category[:name]
    Category.create!(:name => cat_name)
    flash[:notice] = "Category '#{cat_name}' crated!"
    redirect_to admin_path
  end

  def new_message message
    message_text = message[:text]
    MessageTemplate.create!(:text => message_text, :category => Category.find_by_name(message[:category]))
    flash[:notice] = "Message '#{message_text}' added in category '#{message[:category]}'"
    redirect_to admin_path
  end

end
