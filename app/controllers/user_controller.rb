class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
    flash.each do |name, msg|
      @name = name
      @msg = msg
      if msg.eql?("Current password can't be blank")
        redirect_to profile_url(:phone_number => resource.phone_number)
      elsif msg.eql?('Password is too short (minimum is 8 characters)')
        redirect_to profile_url(:phone_number => resource.phone_number)
      elsif msg.eql?('Current password is invalid')
        redirect_to profile_url(:phone_number => resource.phone_number)
      end
    end
  end

  def new_subscription
    @subscribed_categories = params[:categories] || {}
    @subscribed_categories.each do |cat|
      cat_id = Category.find_by_name(cat).id
      current_user = User.find_by_phone_number(params[:phone_number])
      if current_user.subscription[cat_id] == nil
        current_user.subscription[cat_id] = {"place_in_queue" => 0}
      end
      current_user.save!
    end
    flash[:notice] = "You have successfully subscribed to new categories!"
    redirect_to profile_url(:phone_number => resource.phone_number)
  end

  def change_availability
    @avail = params[:availabilities] || {}
    @user = User.find_by_phone_number(params[:phone_number])
    @user.availability = @avial
    @user.save!
    flash[:ntice] = "Your availability has been changed"
    redirect_to profile_url(:phone_number => resource.phone_number)
  end
end
