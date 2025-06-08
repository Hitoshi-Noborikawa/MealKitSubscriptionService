class MealSetItem < ApplicationRecord
  belongs_to :meal_set
  belongs_to :meal
end
