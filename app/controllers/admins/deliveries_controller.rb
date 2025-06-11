class Admins::DeliveriesController < Admins::ApplicationController
  before_action :set_delivery, only: %i[show update]

  def index
    @deliveries = Delivery.order(delivery_date: :desc).limit(20)
  end

  def show
  end

  def update
    if @delivery.update(status: params[:delivery][:status])
      flash[:notice] = "配送##{@delivery.id} のステータスを「#{@delivery.status}」に更新しました"
    else
      flash[:alert] = 'ステータス変更に失敗しました'
    end
    redirect_to admins_deliveries_path
  end

  private

  def set_delivery
    @delivery = Delivery.find(params[:id])
  end
end
