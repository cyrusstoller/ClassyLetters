class RegistrationsController < Devise::RegistrationsController
  protected
  
  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      new_letter_order_path
    else
      super
    end
  end
end
