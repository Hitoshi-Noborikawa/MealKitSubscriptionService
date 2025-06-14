class MealSet < ApplicationRecord
  has_one_attached :thumbnail do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  has_many :meal_set_items, dependent: :destroy
  has_many :meals, through: :meal_set_items
  has_many :delivery_meal_sets, dependent: :destroy
  has_many :deliveries, through: :delivery_meal_sets

  accepts_nested_attributes_for :meal_set_items, allow_destroy: true

  validates :name, presence: true
  validates :thumbnail, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(20.megabytes) }
end
