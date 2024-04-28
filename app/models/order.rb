class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  belongs_to :delivery_agent
  enum status: %i[order_placed delivery_agent_assigned out_for_delivery delivered]
end
