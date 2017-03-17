class Admins::VotingsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_voting, only: %w(show edit update)

  def index
    @votings = Voting.all.order('created_at desc')
  end

  def new
    @voting = Voting.new
    @voting.proposals.build
    User.all.each { |u| @voting.submits.build(user_id: u.id) }

    @groups = Group.all
  end

  def create
    @voting = Voting.new(voting_params)

    # voting {proposals_attributes, submits_attributes} 作成
    # decision 手動作成(proposalがview側で動的作成なため、view側で定義するコストが高いため)
    ActiveRecord::Base.transaction do
      @voting.save
      @voting.submits.each do |s|
        @voting.proposals.each { |p| s.decisions.create(proposal_id: p.id) }
      end
    end
      @voting.submits.each { |s| s.send_invite_submittion_mail }
      redirect_to admins_votings_url, notice: t('.admins.votings.notice')
    rescue => e
      logger.fatal e.message
      logger.fatal e.backtrace.join("\n")
      redirect_to admins_votings_url, notice: t('.admins.votings.error')
  end

  private

  def set_voting
    @voting = Voting.find(params[:id])
  end

  def voting_params
    params.require(:voting).permit(
      :title, 
      :description,
      submits_attributes: [:user_id, :_destroy],
      proposals_attributes: [:id, :title, :body, :_destroy],
      submit_decisions_attributes: [:proposal_id]
    )
  end
end
