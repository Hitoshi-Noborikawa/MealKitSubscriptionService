class Plan < ApplicationRecord
  has_many :subscriptions, dependent: :restrict_with_exception

  validates :name,            presence: true
  validates :price,           presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :meal_sets_count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(price: :asc) }
end
