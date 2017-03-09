class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %w(edit update, destroy)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if  @user.save
      redirect_to admins_users_url, notice: t('.admins.users.notice')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: t(".admins.users.notice")
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admins_users_url, notice: t(".admins.users.notice")
    else 
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name, 
      :email,
      :password,
      :confirmation_password
    )
  end
end
