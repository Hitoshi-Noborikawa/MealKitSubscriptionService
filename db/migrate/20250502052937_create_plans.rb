class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :price, null: false, default: 0
      t.integer :meal_sets_count, null: false, default: 1

      t.timestamps
    end
  end
end
