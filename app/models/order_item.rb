class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :food
  belongs_to :user
end
