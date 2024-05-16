module Services
  module CartService
    class CartTotalCalculator
      DELIVERY_CHARGE = 30
      FREE_DELIVERY = 0
      MINIMUM_AMOUNT_FOR_FREE_DELIVERY = 500

      def initialize(user, coupon_code = nil)
        @cart_items = OrderItem.where(user: user, ordered: false)
        @coupon = find_coupon(coupon_code)
      end

      def calculate_total
        subtotal = @cart_items.pluck(:subtotal).sum
        delivery_charge = subtotal >= MINIMUM_AMOUNT_FOR_FREE_DELIVERY ? FREE_DELIVERY : DELIVERY_CHARGE
        coupon_discount = apply_coupon_discount(subtotal)
        promotions_discount = @cart_items.pluck(:discount).sum
        discount = promotions_discount + coupon_discount
        total = subtotal + delivery_charge - discount
        {
          subtotal: subtotal,
          delivery_charge: delivery_charge,
          coupon_discount: coupon_discount,
          discount: discount,
          total: total
        }
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
