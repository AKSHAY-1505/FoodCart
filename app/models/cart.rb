class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :foods, through: :cart_items
  belongs_to :coupon, optional: true

  def apply_coupon(code)
    coupon = Coupon.find_by(code: code)
    Services::CartHelper::CartCouponApplier.new(self, coupon).call
  end
end
