class Delivery < ApplicationRecord
  extend Enumerize

  belongs_to :subscription
  belongs_to :address
  has_many :delivery_meal_sets, dependent: :destroy
  has_many :meal_sets, through: :delivery_meal_sets

  accepts_nested_attributes_for :delivery_meal_sets, allow_destroy: true

  # TOOD: predicates: trueいる？
  enumerize :time_slot, in: { am: 0, pm: 1 }, default: :am, predicates: true
  enumerize :status, in: { preparing: 0, shipped: 1, delivered: 2 }, default: :preparing, predicates: true

  # TODO: 命名
  before_validation :assign_fees_and_total
  validate :meal_sets_count_within_limit
  validate :delivery_date_interval_valid

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

    # 基本料金は「プラン価格 × 選択セット数」
    base = subscription.plan.price

    # 合計金額を算出
    self.total_price = base + shipping_fee + frozen_fee + cod_fee + schedule_fee
  end

  def meal_sets_count_within_limit
    # NOTE: _destroyがtrueなものは除外 https://railsguides.jp/active_record_validations.html
    valid_meal_sets = delivery_meal_sets.reject(&:marked_for_destruction?)
    max_count = subscription&.plan&.meal_sets_count || 1

    # TODO: 個数が足りない場合も制御する
    if valid_meal_sets.sum(&:quantity) > max_count
      errors.add(:base, "食材セットは最大#{max_count}個まで選択できます")
    end
  end

  def delivery_date_interval_valid
    return if delivery_date.blank? || subscription.blank?

    # 最後の配送を取得
    last_delivery = subscription.deliveries.where.not(id: self.id).order(delivery_date: :desc).first
    return unless last_delivery

    case subscription.frequency
    when 'weekly'
      if (delivery_date - last_delivery.delivery_date).to_i < 7
        errors.add(:delivery_date, 'は前回配送から7日以上空けて選択してください')
      end
    when 'twice_a_month'
      if (delivery_date - last_delivery.delivery_date).to_i < 15
        errors.add(:delivery_date, 'は前回配送から15日以上空けて選択してください')
      end
    end
  end
end
