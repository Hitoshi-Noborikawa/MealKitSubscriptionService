class AddFeeToDeliveries < ActiveRecord::Migration[8.0]
  def change
    add_column :deliveries, :shipping_fee, :integer, null: false, default: 0
    add_column :deliveries, :frozen_fee, :integer, null: false, default: 0
    add_column :deliveries, :cod_fee, :integer, null: false, default: 0
    add_column :deliveries, :schedule_fee, :integer, null: false, default: 0
  end
end
