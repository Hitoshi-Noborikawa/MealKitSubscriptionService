class Users::Subscriptions::DeliveriesController < Users::Subscriptions::ApplicationController
  before_action :set_delivery, only: %i[show edit update]

  def index
    @deliveries = @subscription.deliveries.default_order
  end

  def show
  end

  def new
    @delivery = @subscription.deliveries.build
    @delivery.delivery_meal_sets.build
  end

  def edit
    # 既存行＋足りない分をビルド
    needed = @subscription.plan.max_meal_set_count - @delivery.delivery_meal_sets.size
    needed.times { @delivery.delivery_meal_sets.build } if needed.positive?
  end

  def create
    @delivery = @subscription.deliveries.build(delivery_params)
    if @delivery.save
      # 次回配送日を更新するロジックなど
      redirect_to users_root_path, notice: '配送を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to users_root_path, notice: '配送を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_delivery
    @delivery = current_user.subscription.deliveries.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(
      :delivery_date, :time_slot, :address_id, :time_slot,
      delivery_meal_sets_attributes: %i[id meal_set_id _destroy]
    )
  end
end
