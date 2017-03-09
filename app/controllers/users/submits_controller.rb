class Users::SubmitsController < ApplicationController
  before_action :authenticate_user!
  before_action :submit_params, only: %w(update)

  def index
    @votings = Voting.all
    @votings.each do |v|
      submit = current_user.submits.find_by(voting_id: v.id)
      v.submited_at = submit.created_at if submit
    end
  end

  def show
  end

  def edit
    voting = Voting.find(params[:id])
    @submit = make_submit(voting)

    if @submit.created_at
      render :show
    else
      voting.proposals.each { |p| @submit.decisions.build(proposal_id: p.id) }
    end
  end

  def update
    Submit.create(submit_params)
    redirect_to  users_submits_path, notice: t('.notice')
  end

  private

  def submit_params
    params.require(:submit).permit(
      :user_id,
      :voting_id,
      decisions_attributes: [:proposal_id, :decision]
    )
  end

  def make_submit(voting)
    current_user.submits.find_by(voting_id: voting.id) || 
      Submit.new(user_id: current_user.id, voting_id: voting.id)
  end
end
