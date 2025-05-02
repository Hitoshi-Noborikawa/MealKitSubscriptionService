class Users::DashboardController < Users::ApplicationController
  def index
    # 次回配送予定
    # @next_delivery = current_user.deliveries
    #                              .where('delivery_date >= ?', Date.current)
    #                              .order(:delivery_date)
    #                              .first

    # 過去配送履歴（直近5件）
    # @deliveries    = current_user.deliveries
    #                              .where('delivery_date < ?', Date.current)
    #                              .order(delivery_date: :desc)
    #                              .limit(5)
  end
end
