class CouponMailer < ApplicationMailer
  def new_coupon(coupon, user)
    @coupon = coupon
    @user = user
    mail(to: @user.email, subject: 'New Coupon On FoodCart')
  end
end
