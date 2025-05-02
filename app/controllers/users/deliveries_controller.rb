class Users::DeliveriesController < Users::ApplicationController
  before_action :set_delivery, only: %i[show edit update]

  def index
    @deliveries = current_user.deliveries.default_order
  end

  def show
  end

  def edit
    if @delivery.delivery_date < Date.current + 3.days
      redirect_to users_deliveries_path, alert: '変更受付期限を過ぎています'
    end
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to users_deliveries_path, notice: '配送情報を更新しました'
    else
      render :edit
    end
  end

  private

  def set_delivery
    @delivery = current_user.deliveries.find(params[:id])
  end

  def delivery_params
    params.except(delivery: [:meal_set_id, :delivery_date, :time_slot])
  end
end
