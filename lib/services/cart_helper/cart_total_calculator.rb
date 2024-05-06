module Services
  module CartHelper
    class CartTotalCalculator
      def initialize(cart)
        @cart = cart
      end

      def call
        subtotal = @cart.cart_items.pluck(:subtotal).sum
        delivery_charge = subtotal >= 500 ? 0 : 30
        coupon_discount = apply_coupon_discount(subtotal)
        promotions_discount = @cart.cart_items.pluck(:discount).sum
        discount = coupon_discount + promotions_discount
        total = subtotal + delivery_charge - discount
        @cart.update(subtotal: subtotal, delivery_charge: delivery_charge, discount: discount, total: total)
      end

      def apply_coupon_discount(subtotal)
        return 0 unless @cart.coupon

        return @cart.coupon.discount unless subtotal < @cart.coupon.min_amount

        @cart.coupon = nil
        0
      end
    end
  end
end
