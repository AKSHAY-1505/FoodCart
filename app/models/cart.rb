class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :foods, through: :cart_items
  belongs_to :coupon, optional: true
end
