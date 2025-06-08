class Meal < ApplicationRecord
  has_many :meal_set_items, dependent: :destroy

  scope :default_order, -> { order(:id) }
end
