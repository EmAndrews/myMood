include Util

class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find_by_phone_number(params[:phone_number])
    if @user.is_admin?
      redirect_to admin_path
    end
    @categories = Category.all
    @days = Util.week_day_prefixes
    @subscribed_categories = @user.subscription.keys

    @subscribed_days = @user.availability.keys
    if params[:commit] == 'Subscribe'
      subscribe_to
    elsif params[:commit] == 'Update'
      change_availability
    else
    end
  end

  def subscribe_to
    @new_subscribed_categories = params[:category_id] || {}
    c_ids = []
    @categories.each { |c| c_ids << c.id.to_s }
    unsubscribe = c_ids -  @new_subscribed_categories
    @user = User.find_by_phone_number(params[:phone_number])
    
    @new_subscribed_categories.each do |cat_id|
      cat = Category.find_by_id(cat_id)
      if @user.subscription[cat_id] == nil
      	if cat.message_templates[0] == nil	#something broke, if we hit this
      		return
      	end
        @user.subscription[cat_id] = {:next_message => cat.message_templates[0].id}
      end
    end
    
    unsubscribe.each do |cat|
      @user.subscription.delete(cat)
    end
    
    @user.save!
    flash[:notice] = 'You have successfully subscribed to new categories!'
    redirect_to profile_path
  end

  def change_availability
    @avail = params['days']
    @user = User.find_by_phone_number(params[:phone_number])
    for_db = {}
    @avail.each do |a|
      for_db[a] = []
    end
    @user.availability = for_db
    @user.save!
    flash[:notice] = 'Your availability has been changed'
    redirect_to profile_path
  end

  ## -- Routed to by: "GET user_messages"
  def get_user_messages
    @processed_messages = ProcessedMessages.where(:user_id => User.find_by_phone_number(current_user.phone_number)).where('date_processed > ?', Date.today - 6)
    @prefixes = Category.find(:all,:select => 'name, prefix')
    @categories = User.find_by_phone_number(current_user.phone_number).subscribed_categories
    #messages_with_prefixes = [@processed_messages, @prefixes]
    respond_to do |format|
      #format.json {render :json => messages_with_prefixes.to_json}
      format.json {
        render :json => {
            :processed_messages => @processed_messages,
            :prefixes => @prefixes,
            :categories => @categories
        }
      }
    end
  end

end
