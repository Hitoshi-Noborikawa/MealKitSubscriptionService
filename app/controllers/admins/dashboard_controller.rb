class Admins::DashboardController < Admins::ApplicationController
  def index
    @today_count   = 0
    @week_count    = 0
    @pending_stops = 0
  end
end
