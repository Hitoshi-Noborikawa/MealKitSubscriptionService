class CreateSubscription < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.integer :frequency, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.datetime :paused_at

      t.timestamps
    end
  end
end
