class Delivery < ApplicationRecord
  extend Enumerize

  belongs_to :subscription
  belongs_to :meal_set

  enumerize :time_slot, in: { am: 0, pm: 1 }, default: :am, predicates: true
  enumerize :status, in: { preparing: 0, shipped: 1 }, default: :preparing, predicates: true

  scope :default_order, -> { order(delivery_date: :asc) }
end
