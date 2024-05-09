module Services
  module CartHelper
    class CartTotalCalculator
      def initialize(user, coupon_code = nil)
        @cart_items = OrderItem.where(user: user, ordered: false)
        @cart_details = {}
        @coupon = Coupon.find_by(code: coupon_code) if coupon_code
      end

      def call
        @cart_details[:subtotal] = @cart_items.pluck(:subtotal).sum
        @cart_details[:delivery_charge] = @cart_details[:subtotal] >= 500 ? 0 : 30
        @cart_details[:coupon_discount] = apply_coupon_discount(@cart_details[:subtotal])
        promotions_discount = @cart_items.pluck(:discount).sum
        @cart_details[:discount] = promotions_discount + @cart_details[:coupon_discount]
        @cart_details[:total] = @cart_details[:subtotal] + @cart_details[:delivery_charge] - @cart_details[:discount]
        @cart_details
      end

      def apply_coupon_discount(subtotal)
        return 0 unless @coupon

        return 0 if subtotal < @coupon.min_amount

        @coupon.discount
      end
    end
  end
end
