class MealSet < ApplicationRecord
  has_many :meal_set_items, dependent: :destroy
  has_many :meals, through: :meal_set_items

  accepts_nested_attributes_for :meal_set_items, allow_destroy: true

  validates :name, presence: true
end
