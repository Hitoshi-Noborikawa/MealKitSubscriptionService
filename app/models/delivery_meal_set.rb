class DeliveryMealSet < ApplicationRecord
  belongs_to :delivery
  belongs_to :meal_set

  validates :meal_set_id, uniqueness: { scope: :delivery_id }
  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: :max_per_delivery }

  private

  def max_per_delivery
    delivery.subscription.plan.meal_sets_count
  end
end
