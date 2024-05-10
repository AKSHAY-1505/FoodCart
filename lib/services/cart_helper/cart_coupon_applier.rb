# module Services
#   module CartHelper
#     class CartCouponApplier
#       def initialize(cart, coupon)
#         @cart = cart
#         @coupon = coupon
#       end

#       def call
#         return { alert: 'Coupon Invalid' } unless @coupon

#         if @cart.subtotal < @coupon.min_amount
#           return { alert: "You need to add Items worth Rs #{@coupon.min_amount - @cart.subtotal} to avail this coupon." }
#         end

#         @cart.coupon = @coupon
#         @cart.save
#         Services::CartHelper::CartTotalCalculator.new(@cart).call
#         { notice: 'Coupon Applied Successfully!' }
#       end
#     end
#   end
# end
