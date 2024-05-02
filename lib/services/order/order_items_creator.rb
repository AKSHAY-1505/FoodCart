module Services
  module Order
    class OrderItemsCreator
      def initialize(order, cart)
        @order = order
        @cart = cart
      end

      def call
        @cart.cart_items.each do |item|
          OrderItem.create(order: @order, food_name: item.food.name, food_price: item.food.price,
                           quantity: item.quantity)
        end
        debugger
        @cart.cart_items.destroy_all
      end
    end
  end
end
