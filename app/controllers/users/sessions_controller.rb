class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #

  def after_sign_in_path_for(resource)
    if resource.password_updated_at
      users_root_path
    else
      edit_users_invitation_password_path
    end
  end

  def after_sign_out_path_for(resource)
    user_session_path
  end

end
