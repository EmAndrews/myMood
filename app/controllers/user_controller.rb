include Util

class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find_by_phone_number(params[:phone_number])
    if @user.is_admin?
      p "HOLY SHIT WE'RE REDIRECTING TO ADMIN"
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
end
