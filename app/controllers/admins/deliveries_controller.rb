class Admins::DeliveriesController < Admins::ApplicationController
  before_action :set_delivery, only: :update

  def index
    @deliveries = Delivery.includes(subscription: :user, delivery_meal_sets: :meal_set).default_order
  end

  def update
    # TODO: ちゃんとvalidateしたい
    if @delivery.update_column(:status, params[:delivery][:status])
      flash[:notice] = "配送##{@delivery.id} のステータスを「#{@delivery.status_text}」に更新しました"
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
