class CreateMealSetItems < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_set_items do |t|
      t.references :meal_set, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
