class Users::Subscriptions::ApplicationController < Users::ApplicationController
  before_action :set_subscription

  private

  def set_subscription
    @subscription = current_user.subscription
  end
end
