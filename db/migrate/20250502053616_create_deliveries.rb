class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :meal_set, null: false, foreign_key: true
      t.date :delivery_date, null: false
      t.integer :time_slot, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.text :delivery_memo
      t.integer :total_price, null: false, default: 0
      t.integer :total_price_with_tax, null: false, default: 0

      t.timestamps
    end
  end
end
