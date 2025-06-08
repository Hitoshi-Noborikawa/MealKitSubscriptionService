class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.boolean :frozen, null: false, default: false

      t.timestamps
    end
  end
end
