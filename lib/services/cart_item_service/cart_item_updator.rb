module Services
  module CartItemService
    class CartItemUpdator
      def initialize(item, quantity)
        @item = item
        @quantity = quantity.to_i
      end

      def update_item_details
        previous_quantity = @item.quantity
        @item.update(quantity: @quantity, subtotal: @item.food.price * @quantity)
        discount = Services::CartItemService::DiscountCalculator.new(@item).calculate_discount
        @item.update(discount: discount)

        @item.food.update(quantity: @item.food.quantity + (previous_quantity - @quantity))
      end
    end
  end
end
