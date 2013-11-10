class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    profile_url(:phone_number => resource.phone_number)
    #profile_path(resource)
  end

  def after_sign_up_path_for(resource)
    #profile_path(resource)
    profile_url(:phone_number => resource.phone_number)
  end

end
