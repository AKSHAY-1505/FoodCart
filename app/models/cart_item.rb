class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  after_create :increase_cart_amount
  before_destroy :reduce_cart_amount
  before_update :update_cart_amount

  private

  def reduce_cart_amount
    amount = quantity * food.price
    cart.total -= amount
    cart.save
  end

  def increase_cart_amount
    amount = quantity * food.price
    cart.total += amount
    cart.save
  end

  def update_cart_amount
    diff_in_quantity = quantity - quantity_was
    amount = food.price * diff_in_quantity
    cart.total += amount
    cart.save
  end
end
