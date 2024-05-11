module Services
  module OrderService
    class OrderItemsCreator
      def initialize(order)
        @order = order
        @user = order.user
      end

      def create_order_items
        order_items = OrderItem.where(user: @user, ordered: false).includes(:food) # to handle n+1 queries

        order_items.each do |item|
          item.food.update(quantity: item.food.quantity - item.quantity)
        end

        order_items.update_all(order_id: @order.id, ordered: true)
      end
    end
  end
end
