class SessionsController < Devise::SessionsController
  protected
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      stored_location_for(resource) || new_letter_order_path
    else
      super
    end
  end  
end
