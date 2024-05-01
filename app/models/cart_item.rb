class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  # after_create :calculate_cart_total
  # after_destroy :calculate_cart_total
  # after_update :calculate_cart_total

  # private

  # def calculate_cart_total
  #   Services::Cart::CartTotalCalculator.new(cart).call
  # end
end
