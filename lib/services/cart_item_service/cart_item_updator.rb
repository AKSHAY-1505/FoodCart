module Services
  module CartItemService
    class CartItemUpdator
      def initialize(item)
        @item = item
      end

      def update_item_details
        @item.update(subtotal: @item.food.price * @item.quantity)
        discount = Services::CartItemService::DiscountCalculator.new(@item).calculate_discount
        @item.update(discount: discount)
      end
    end
  end
end
