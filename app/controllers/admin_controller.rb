require 'logger'
include Util

class AdminController < ApplicationController
  before_filter :authenticate_user!

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
  
    #TODO Find message sequence number
    cat = Category.find_by_name(message[:category])
    seq_num = cat.message_templates.count + 1
    MessageTemplate.create!(:text => message_text, :category => cat, :sequence_number => seq_num)
    flash[:notice] = "Message '#{message_text}' added in category '#{message[:category]}'"
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

  def delete_category category
    flash[:notice] = "Category '#{category.name}' and messages deleted."
    Category.destroy(category.id)
  end

  def delete_message message
    puts "admin>> Deleting message #{message.text}, #{message.sequence_number}"
    cat = message.category
    cat.update_seqs_by_removing(message)
    MessageTemplate.destroy(message.id)
    flash[:notice] = "Message '#{message.text}' deleted."
  end

end
