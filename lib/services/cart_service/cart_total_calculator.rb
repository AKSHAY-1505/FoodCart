module Services
  module CartService
    # This class is responsible for calculating the total amount of the cart.
    class CartTotalCalculator
      DELIVERY_CHARGE = 30
      FREE_DELIVERY = 0
      MINIMUM_AMOUNT_FOR_FREE_DELIVERY = 500

      def initialize(user, coupon_code = nil)
        @cart_items = OrderItem.where(user: user, ordered: false)
        @coupon = find_coupon(coupon_code)
        @cart_details = {}
      end

      def calculate_total
        @cart_details[:subtotal] = @cart_items.pluck(:subtotal).sum
        @cart_details[:delivery_charge] = @cart_details[:subtotal] >= MINIMUM_AMOUNT_FOR_FREE_DELIVERY ? FREE_DELIVERY : DELIVERY_CHARGE
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

      def find_coupon(code)
        return unless code

        Coupon.where('code = ? AND from_date <= ? AND to_date >= ?', code, Time.now, Time.now).first
      end
    end
  end
end
