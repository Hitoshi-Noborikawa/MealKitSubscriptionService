class User < ApplicationRecord
  extend Enumerize

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :subscription, dependent: :destroy

  enumerize :shipping_zone, in: { hokkaido_okinawa: 0, others: 1 }, default: :others, predicates: true
end
