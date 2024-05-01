module Services
  module Cart
    class CartDiscountApplier
      def initialize(cart)
        @cart = cart
      end

      def call
        @cart.cart_items.each do |item|
          item_discount = Services::CartItemHelper::DiscountCalculator.new(item).call
          item.update(discount: item_discount)
        end
      end
    end
  end
end
