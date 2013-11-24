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
    if commit == 'Add Message'
      new_message params[:message]
    elsif commit == 'Add Category'
      new_category params[:category]
    else
      redirect_to admin_path
    end
  end

  def new_category category
    if category[:name] == '' || category[:prefix] == ''
      flash[:notice] = 'Please include a category name and prefix.'
      redirect_to admin_path
      return
    end
    unless category[:prefix].match(/^[a-zA-Z]+$/)
      flash[:notice] = 'Only letters are allowed in the prefix.'
      redirect_to admin_path
      return
    end
    cat_name = category[:name]
    Category.create!(category)
    flash[:notice] = "Category '#{cat_name}' created!"
    redirect_to admin_path
  end
  
  def new_message message
    message_text = message[:text]
  
    if message_text == ""
      flash[:notice] = "Message cannot be blank."
      redirect_to admin_path
      return
    end
  
    MessageTemplate.create!(:text => message_text, :category => Category.find_by_name(message[:category]))
    flash[:notice] = "Message '#{message_text}' added in category '#{message[:category]}'"
    redirect_to admin_path
  end

=begin
  def new_category category
    cat_name = category[:name]
    Category.create!(:name => cat_name)
    flash[:notice] = "Category '#{cat_name}' created!"
    redirect_to admin_path
  end

  def new_message message
    message_text = message[:text]
    MessageTemplate.create!(:text => message[:text], :category => Category.find_by_name(message[:category]))
    flash[:notice] = "Message '#{message_text}' added with category '#{message[:category]}'!"
    redirect_to admin_path
  end

  def delete_something
    if params[:message_id]
      id = params[:message_id].keys[0]
      message = MessageTemplate.find_by_id(id)
      delete_message message
    elsif params[:category_id]
      id = params[:category_id].keys[0]
      category = Category.find_by_id(id)
      delete_category category
    end
    redirect_to admin_path
  end
=end
  def delete_category category
    flash[:notice] = "Category '#{category.name}' and messages deleted."
    Category.destroy(category.id)
  end

  def delete_message message
    MessageTemplate.destroy(message.id)
    flash[:notice] = "Message '#{message.text}' deleted."
  end

end
