module Services
  module CartService
    class CartDiscountApplier
      def initialize(cart_items)
        @cart_items = cart_items
      end

      def call
        @cart_items.each do |item|
          item_discount = Services::CartItemService::DiscountCalculator.new(item).call
          item.update(discount: item_discount)
        end
      end
    end
  end
end
