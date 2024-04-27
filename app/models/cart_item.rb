class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  after_create :increase_cart_amount
  before_destroy :reduce_cart_amount

  private

  def reduce_cart_amount
    cart = self.cart
    amount = self.quantity * self.food.price
    cart.total -= amount
    cart.save
  end

  def increase_cart_amount
    cart = self.cart
    amount = self.quantity * self.food.price
    cart.total += amount
    cart.save
  end
end
