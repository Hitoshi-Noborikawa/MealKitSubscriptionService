class Users::SubscriptionsController < Users::ApplicationController
  before_action :set_subscription, only: %i[show edit update]

  def show
  end

  def new
    @subscription = current_user.build_subscription
  end

  def edit
    @subscription = current_user.subscription
  end

  def create
    @subscription = current_user.build_subscription(subscription_params)
    if @subscription.save
      redirect_to users_root_path, notice: 'プランを設定しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to users_root_path, notice: '契約内容を更新しました'
    else
      render :edit
    end
  end

  private

  def set_subscription
    @subscription = current_user.subscription
  end

  def subscription_params
    # TODO: paused_atも保存できるように
    params.require(:subscription).permit(:plan_id, :frequency)
  end
end
