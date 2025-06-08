class ChangeColumnMealSets < ActiveRecord::Migration[8.0]
  def change
    remove_column :meal_sets, :price, :integer
    remove_column :meal_sets, :included_items, :text
    remove_column :meal_sets, :weight, :float
    remove_column :meal_sets, :allergy_info, :text
    remove_column :meal_sets, :refrigerated, :text
    add_column :meal_sets, :description, :text, default: false, default: ''
  end
end
