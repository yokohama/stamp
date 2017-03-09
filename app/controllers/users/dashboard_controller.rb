class Users::DashboardController < ApplicationController
  before_action :authenticate_user!
end
