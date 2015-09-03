class LeaderboardController < ApplicationController
  before_filter :sort_users

  def index
    @users
  end

  private
    def sort_users
      @users = User.all.sort_by { |user| user.reports.count }.reverse!
    end
end
