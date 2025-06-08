class Meal < ApplicationRecord
  has_many :meal_set_items, dependent: :destory
end
