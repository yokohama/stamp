class Users::SubmitsController < ApplicationController
  before_action :authenticate_user!
  before_action :submit_params, only: %w(update)

  def index
    @submits = current_user.submits.order('created_at desc')
  end

  def show
  end

  def edit
    @submit = current_user.submits.find(params[:id])

    if @submit.submited_at.nil?
      render :edit
    else
      render :show
    end
  end

  def update
    @submit = current_user.submits.find(params[:id])
    @submit.submited_at = DateTime.now
    @submit.update(submit_params)
    redirect_to  users_submits_path, notice: t('.notice')
  end

  private

  def submit_params
    params.require(:submit).permit(
      :user_id,
      :voting_id,
      :delegater,
      decisions_attributes: [:id, :proposal_id, :decision]
    )
  end
end
