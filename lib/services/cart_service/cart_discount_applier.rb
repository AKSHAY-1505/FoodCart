module Services
  module CartService
    # This class is responsible for applying the discount to the cart items.
    class CartDiscountApplier
      DISCOUNT_CALCULATOR_CLASS = Services::CartItemService::DiscountCalculator

      def initialize(cart_items)
        @cart_items = cart_items
      end

      def apply_discount
        @cart_items.each do |item|
          item_discount = DISCOUNT_CALCULATOR_CLASS.new(item).calculate_discount
          item.update(discount: item_discount)
        end
      end
    end
  end
end
