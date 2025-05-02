class Users::SubscriptionsController < Users::ApplicationController
  before_action :set_subscription, only: %i[edit update]

  def new
    @subscription = current_user.subscription || current_user.build_subscription
    @subscription.deliveries.build
  end

  def create
    @subscription = current_user.build_subscription(subscription_params)
    if @subscription.save!
      redirect_to users_root_path, notice: 'プラン＆配送スケジュールを設定しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to users_root_path, notice: '設定を更新しました'
    else
      render :edit
    end
  end

  private

  def set_subscription
    @subscription = current_user.subscription
  end

  def subscription_params
    params.require(:subscription)
          .permit(
            :plan_id,
            :frequency,
            :next_delivery_date,
            deliveries_attributes: %i[meal_set_id delivery_date time_slot _destroy]
          )
  end
end
