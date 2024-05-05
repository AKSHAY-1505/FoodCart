class Customer < ApplicationRecord
  belongs_to :user
  # validates :phone_number, length: { is: 10, message: 'must be 10 digits!' }
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  after_create :create_cart

  private

  def create_cart
    Cart.create(customer: self)
  end
end
