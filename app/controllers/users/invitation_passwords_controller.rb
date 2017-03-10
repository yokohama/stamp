class Users::InvitationPasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %w(edit update)

  def update
    @user.password_updated_at = DateTime.now
    if @user.update(user_params)
      sign_in(@user, bypass: true) if current_user.id == @user.id
      redirect_to users_root_path, notice: t('.users.invitation_passwords.notice')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :password, 
      :password_confirmation
    )
  end
end
