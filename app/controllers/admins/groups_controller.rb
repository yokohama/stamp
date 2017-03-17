class Admins::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: %w(show edit update destroy)

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    User.all.each { |u| @group.user_groups.build(user_id: u.id) }
  end

  def create
    @group = Group.new(group_params)
    if  @group.save
      redirect_to admins_groups_url, notice: t('.admins.groups.notice')
    else
      render :new
    end
  end

  def show
    render json: @group.users.map(&:id)
  end

  def edit
    (User.all.map(&:id) - @group.user_groups.map(&:user).map(&:id)).each do |u_id| 
      @group.user_groups.build(user_id: u_id) 
    end
  end

  def update
    if @group.update(group_params)
      redirect_to admins_groups_path(@group), notice: t(".admins.votings.notice")
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to admins_groups_url, notice: t(".admins.groups.notice")
    else 
      render :index
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name,
      user_groups_attributes: [:id, :user_id, :_destroy]
    )
  end
end
