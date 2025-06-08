class RemoveMealSetReferenceToDeliveries < ActiveRecord::Migration[8.0]
  def change
    remove_reference :deliveries, :meal_set, index: true, foreign_key: true
  end
end
