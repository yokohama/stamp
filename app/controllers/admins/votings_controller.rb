class Admins::VotingsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_voting, only: %w(show edit update)

  def index
    @votings = Voting.all.order('created_at desc')
  end

  def new
    @voting = Voting.new
    @voting.proposals.build
    User.all.each do |u|
      @voting.submits.build(user_id: u.id)
    end
  end

  def edit
    @voting.proposals.build
  end

  def create
    @voting = Voting.new(voting_params)

    ActiveRecord::Base.transaction do

      # チェックされていないレコードの削除
      # HACK: jsで、_deleteを1にしてあげるとここでのコードがなくなるかも。
      @voting.submits.each_with_index do |s, i|
        @voting.submits[i].destroy if s.user_id == 0
      end

      @voting.save
      @voting.submits.each do |s|
        # HACK: 上で０のものを消しているはずなのに、残っているのでまたここでもifが必要。
        # voting.submits.countは正しいが、voting.submits.lengthや、voting.submit.eachをすると０のものが残っている。
        unless s.user_id == 0
          @voting.proposals.each do |p| 
            s.decisions.create(proposal_id: p.id) 
          end
        end
      end

    end
      @voting.submits.each do |s|
        unless s.user_id == 0
          s.send_invite_submittion_mail
        end
      end
      redirect_to admins_votings_url, notice: t('.admins.votings.notice')
    rescue => e
      render :new
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
      submits_attributes: [:user_id, :_destroy],
      proposals_attributes: [:id, :title, :body, :_destroy]
    )
  end
end
