class CreateDeliveryMealSets < ActiveRecord::Migration[8.0]
  def change
    create_table :delivery_meal_sets do |t|
      t.references :delivery, null: false, foreign_key: true
      t.references :meal_set, null: false, foreign_key: true

      t.timestamps
    end

    add_index :delivery_meal_sets, %i[delivery_id meal_set_id], unique: true
  end
end
