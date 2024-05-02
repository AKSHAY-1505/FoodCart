class Customer < ApplicationRecord
  belongs_to :user
  # validates :phone_number, length: { is: 10, message: 'must be 10 digits!' }
  has_one :cart
  has_many :orders
  after_create :create_cart
  has_many :addresses

  private

  def create_cart
    Cart.create(customer: self)
  end
end
