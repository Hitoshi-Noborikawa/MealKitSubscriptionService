class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :address, :text, null: false, default: ''
    add_column :users, :prefecture, :string, null: false, default: ''
    add_column :users, :shipping_zone, :integer, null: false, default: 1
    add_column :users, :phone_number, :string, null: false, default: ''
    add_column :users, :allergy_notes, :text, null: false, default: ''
    add_column :users, :suspended, :boolean, null: false, default: false
    add_column :users, :deliveries_count, :integer, null: false, default: 0
  end
end
