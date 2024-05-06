class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  after_create :calculate_cart_total
  after_destroy :calculate_cart_total
  after_update :calculate_cart_total

  private

  def calculate_cart_total
    # validate_coupon
    Services::CartHelper::CartTotalCalculator.new(cart).call
  end

  # def validate_coupon
  #   return unless cart.coupon

  #   return unless cart.subtotal < cart.coupon.min_amount

  #   cart.coupon = nil
  #   cart.save
  # end
end
