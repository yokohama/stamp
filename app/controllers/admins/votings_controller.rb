class Admins::VotingsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_voting, only: %w(show edit update)

  def index
    @votings = Voting.all
  end

  def new
    @voting = Voting.new
    @voting.proposals.build
  end

  def edit
    @voting.proposals.build
  end

  def create
    @voting = Voting.new(voting_params)
    if @voting.save
      redirect_to admins_votings_url, notice: t('.admins.votings.notice')
    else
      render :new
    end
  end

  def update
    if @voting.update(voting_params)
      redirect_to admins_voting_path(@voting), notice: t(".admins.votings.notice")
    else
      render :edit
    end
  end

  private

  def set_voting
    @voting = Voting.find(params[:id])
  end

  def voting_params
    params.require(:voting).permit(
      :title, 
      :description,
      proposals_attributes: [:id, :title, :body, :_destroy]
    )
  end
end
