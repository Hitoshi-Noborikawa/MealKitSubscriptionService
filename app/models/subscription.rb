class Subscription < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :plan
  has_many :deliveries, dependent: :destroy

  enumerize :frequency, in: { weekly: 0, twice_a_month: 1 }, default: :weekly, predicates: true

  accepts_nested_attributes_for :deliveries, allow_destroy: true
end
