module Services
  module Cart
    class CartTotalCalculator
      def initialize(cart)
        @cart = cart
      end

      def call
        subtotal = @cart.cart_items.pluck(:subtotal).sum
        delivery_charge = subtotal >= 500 ? 0 : 30
        discount = @cart.cart_items.pluck(:discount).sum
        total = subtotal + delivery_charge - discount
        @cart.update(subtotal: subtotal, delivery_charge: delivery_charge, discount: discount, total: total)
      end

    end
  end
end
