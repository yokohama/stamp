class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @votings = Voting.all
  end
end
