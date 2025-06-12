class Delivery < ApplicationRecord
  extend Enumerize

  belongs_to :subscription
  belongs_to :address
  has_many :delivery_meal_sets, dependent: :destroy
  has_many :meal_sets, through: :delivery_meal_sets

  accepts_nested_attributes_for :delivery_meal_sets, allow_destroy: true

  # TOOD: predicates: trueいる？
  enumerize :time_slot, in: { am: 0, pm: 1 }, default: :am, predicates: true
  # TODO: 完了が欲しい
  enumerize :status, in: { preparing: 0, shipped: 1 }, default: :preparing, predicates: true

  # TODO: 命名
  before_validation :assign_fees_and_total

  scope :default_order, -> { order(delivery_date: :asc) }

  private

  def assign_fees_and_total
    # TODO: リファクタ
    # 配送料を計算
    self.shipping_fee = if %i[北海道 沖縄].include?(address.prefecture)
                          800
                        else
                          500
                        end
    # 冷凍品追加料金を計算(選択したセット内の合計冷凍品数 × 100円)
    frozen_items_count = meal_sets.sum do |ms|
      ms.meal_set_items.count { |item| item.meal.frozen? }
    end
    self.frozen_fee = frozen_items_count * 100

    # 代引き手数料を固定で設定
    self.cod_fee = 300

    # スケジュール手数料
    self.schedule_fee = subscription.frequency.twice_a_month? ? 500 : 0

    # 基本料金は「プラン価格 × 選択セット数」
    total_sets = delivery_meal_sets.sum(&:quantity)
    base = subscription.plan.price * total_sets

    # 合計金額を算出
    self.total_price = base + shipping_fee + frozen_fee + cod_fee + schedule_fee
  end
end
