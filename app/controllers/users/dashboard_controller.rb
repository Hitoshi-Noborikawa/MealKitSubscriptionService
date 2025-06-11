class Users::DashboardController < Users::ApplicationController
  def index
    @subscription = current_user.subscription
    @deliveries = @subscription&.deliveries&.order(delivery_date: :asc) || []
  end
end
