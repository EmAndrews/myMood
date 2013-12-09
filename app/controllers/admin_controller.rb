require 'logger'
include Util

class AdminController < ApplicationController
  before_filter :authenticate_admin

  def authenticate_admin
    authenticate_user!
    @user = User.find_by_phone_number(current_user.phone_number)
    unless @user.is_admin?
      redirect_to '/'
    end
  end

  def index
    Rails.logger.debug('Hi Admin')
    @messages = MessageTemplate.all
    @categories = Category.all
    if params[:commit] == "Download CSV"
      download
    end
  end


  def new_something
    commit = params[:commit]
    if commit == 'Add Message'
      new_message params[:message]
    elsif commit == 'Add Category'
      new_category params[:category]
    elsif commit == 'Add Admin'
      create_new_admin params[:admin_phone_number][:text]
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
  
  def create_new_admin admin_phone
    if User.find_by_phone_number(admin_phone)
      new_admin = User.find_by_phone_number(admin_phone)
      new_admin.is_admin = true
      name = new_admin.name
      new_admin.save!
      flash[:notice] = "#{name} has been given admin access"
    else
      flash[:alert] = "Sorry, there is no user that matches that phone number"
    end
    redirect_to admin_path
  end
  
  def download
    csv_file = ProcessedMessages.gen_csv()
    send_data csv_file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=test.csv"
  end

  def get_user_messages
    # need messages from every user from the last 7 days
    @processed_messages = ProcessedMessages.where('date_processed > ?', Date.today - 6)
    @prefixes = Category.find(:all,:select => 'name, prefix')
    respond_to do |format|
      format.json {
        render :json => {
            :processed_messages => @processed_messages,
            :prefixes => @prefixes,
        }
      }
    end
  end
end
