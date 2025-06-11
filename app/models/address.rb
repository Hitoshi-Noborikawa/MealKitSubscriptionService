class Address < ApplicationRecord
  belongs_to :user

  # TODO: presence: trueはまとめて書くべきなのか？
  validates :postal_code, :prefecture, :city, :street, :phone_number, presence: true

  def full_address
    "〒#{postal_code} #{prefecture}#{city}#{street}"
  end
end
