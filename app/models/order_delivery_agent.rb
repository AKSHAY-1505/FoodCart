class OrderDeliveryAgent < ApplicationRecord
  belongs_to :order
  belongs_to :user
  validates :assigned_at, presence: true
end
