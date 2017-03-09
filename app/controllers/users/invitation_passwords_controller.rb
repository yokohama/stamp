class Users::InvitationPasswordsController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.password_updated_at = DateTime.now
    if current_user.update(user_params)
      redirect_to users_root_path, notice: t('.users.invitation_passwords.notice')
    else
      redirect_to edit_users_invitation_password_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :password, 
      :password_confirmation
    )
  end
end
