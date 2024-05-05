class AddCouponIdToCarts < ActiveRecord::Migration[7.1]
  def change
    add_reference :carts, :coupon, foreign_key: true
  end
end
