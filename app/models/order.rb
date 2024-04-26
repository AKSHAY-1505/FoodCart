class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  enum status: [:order_placed,:out_for_delivery,:delivered]

end
