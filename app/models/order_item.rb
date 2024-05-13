class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :food
  belongs_to :user

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_destroy :increase_food_stock

  def increase_food_stock
    food = self.food
    previous_quantity = food.quantity
    food.update(quantity: previous_quantity + quantity)
  end
end
