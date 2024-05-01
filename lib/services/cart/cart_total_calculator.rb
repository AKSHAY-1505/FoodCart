module Services
  module Cart
    class CartTotalCalculator
      def initialize(cart)
        @cart = cart
      end

      def call
        subtotal = @cart.cart_items.sum { |item| item.quantity * item.food.price }
        delivery_charge = subtotal >= 500 ? 0 : 30
        item_discounts = Services::Cart::DiscountCalculator.new(@cart.cart_items).call
        discount = item_discounts.values.sum
        total = subtotal + delivery_charge - discount
        @cart.update(subtotal: subtotal, delivery_charge: delivery_charge, discount: discount, total: total)
        item_discounts
      end

    end
  end
end
