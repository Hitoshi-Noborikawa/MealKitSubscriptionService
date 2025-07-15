class Delivery < ApplicationRecord
  extend Enumerize

  belongs_to :subscription
  belongs_to :address
  has_many :delivery_meal_sets, dependent: :destroy
  has_many :meal_sets, through: :delivery_meal_sets

  accepts_nested_attributes_for :delivery_meal_sets, allow_destroy: true

  enumerize :time_slot, in: { am: 0, pm: 1 }, default: :am, predicates: true
  enumerize :status, in: { preparing: 0, shipped: 1, delivered: 2 }, default: :preparing, predicates: true

  before_validation :set_fees_and_total
  validate :meal_sets_count_within_limit
  validate :validate_delivery_date_interval

  scope :default_order, -> { order(delivery_date: :asc) }
  scope :excluding_by, ->(record) { where.not(id: record.id) }

  private

  def set_fees_and_total
    self.shipping_fee = calculated_shipping_fee
    self.frozen_fee = frozen_items_count * 100
    # NOTE: 代引き手数料は一旦固定で設定
    self.cod_fee = 300
    base_price = subscription.plan.price
    self.total_price = base_price + shipping_fee + frozen_fee + cod_fee + schedule_fee
  end

  def meal_sets_count_within_limit
    # NOTE: _destroyがtrueなものは除外 https://railsguides.jp/active_record_validations.html
    valid_meal_sets = delivery_meal_sets.reject(&:marked_for_destruction?)
    max_meal_set_count = subscription&.plan&.meal_sets_count || 1

    # TODO: 個数が足りない場合も制御するように
    if valid_meal_sets.sum(&:quantity) > max_meal_set_count
      errors.add(:base, "食材セットは最大#{max_meal_set_count}個まで選択できます")
    end
  end

  def frozen_items_count
    delivery_meal_sets.reject(&:marked_for_destruction?).sum do |dms|
      ms = dms.meal_set || MealSet.find_by(id: dms.meal_set_id)
      next 0 unless ms

      ms.meal_set_items.to_a.sum do |item|
        meal = item.meal || Meal.find_by(id: item.meal_id)
        next 0 unless meal&.refrigeration?
        item.quantity.to_i * dms.quantity.to_i
      end
    end
  end

  def calculated_shipping_fee
    if %i[北海道 沖縄].include?(address.prefecture)
      800
    else
      500
    end
  end

  def validate_delivery_date_interval
    return if delivery_date.blank? || subscription.blank?

    # NOTE: 最後の配送を取得
    last_delivery = subscription.deliveries.excluding_by(self).order(delivery_date: :desc).first
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
