class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
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
end
