class RemoveAddressFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :address, :text
    remove_column :users, :prefecture, :string
    remove_column :users, :shipping_zone, :integer
    remove_column :users, :deliveries_count, :integer
  end
end
