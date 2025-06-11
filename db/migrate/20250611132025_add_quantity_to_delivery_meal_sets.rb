class AddQuantityToDeliveryMealSets < ActiveRecord::Migration[8.0]
  def change
    add_column :delivery_meal_sets, :quantity, :integer, null: false, default: 1
  end
end
