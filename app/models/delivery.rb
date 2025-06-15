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
  validate :delivery_date_matches_frequency

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

  def meal_sets_count_within_limit
    # NOTE: _destroyがtrueなものは除外 https://railsguides.jp/active_record_validations.html
    valid_meal_sets = delivery_meal_sets.reject { |dms| dms.marked_for_destruction? }
    max_count = subscription.plan.meal_sets_count || 1
    if valid_meal_sets.size > max_count
      errors.add(:base, "食材セットは最大#{max}個まで選択できます")
    end
  end

  def delivery_date_matches_frequency
    return if delivery_date.blank? || subscription.blank?

    case subscription.frequency
    when 'weekly'
      errors.add(:delivery_date, 'は週1コースの曜日のみ指定できます') unless delivery_date.sunday?
    when 'twice_a_month'
      unless [5, 20].include?(delivery_date.day)
        errors.add(:delivery_date, 'は月2コースの指定日のみ選択できます')
      end
    end
  end
end
