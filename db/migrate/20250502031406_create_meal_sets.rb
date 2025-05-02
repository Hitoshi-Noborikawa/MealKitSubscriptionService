class CreateMealSets < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_sets do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :included_items, null: false
      t.float :weight, null: false
      t.boolean :refrigerated, null: false
      t.text :allergy_info, null: false, default: ''

      t.timestamps
    end
  end
end
