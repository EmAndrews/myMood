class RegistrationsController < Devise::RegistrationsController

  #protected

  def update

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => profile_url(:phone_number => resource.phone_number)
    else
      clean_up_passwords resource
      flash[:alert] = 'Failed to update settings'
      #set_flash_message :notice,
      redirect_to profile_url(:phone_number => resource.phone_number)
      #respond_with resource, :location => '/'
      #respond_with resource, :location => profile_url(:phone_number => resource.phone_number)
    end
    #
    # Devise use update_with_password instead of update_attributes.
    # This is the only change we make.

    #if resource.update_attributes(params[resource_name])
    #  set_flash_message :notice, :updated
    #  # Line below required if using Devise >= 1.2.0
    #  sign_in resource_name, resource, :bypass => true
    #  redirect_to after_update_path_for(resource)
    #else
    #  clean_up_passwords(resource)
    #  respond_with resource, :location => after_update_path_for(resource)
    #  #profile_url(:phone_number => resource.phone_number)
    #end
  end
end