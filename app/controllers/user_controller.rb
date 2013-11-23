class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
    @days = %w(M Tu W Th F Sa Su)
    @user = User.find_by_phone_number(params[:phone_number])
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
    
    @new_subscribed_categories.each do |cat|
      if @user.subscription[cat] == nil
        @user.subscription[cat] = {'place_in_queue' => 0}
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
