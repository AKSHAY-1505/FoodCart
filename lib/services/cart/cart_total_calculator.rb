module Services
  module Cart
    class CartTotalCalculator
      def initialize(cart)
        @cart = cart
      end

      def call
        subtotal = @cart.cart_items.sum { |item| item.quantity * item.food.price }
        delivery_charge = subtotal >= 500 ? 0 : 30
        discount = 0 # Assuming no discount logic for simplicity
        total = subtotal + delivery_charge - discount
        @cart.update(subtotal: subtotal, delivery_charge: delivery_charge, discount: discount, total: total)
      end
    end
  end
end
