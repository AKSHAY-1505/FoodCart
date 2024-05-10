module Services
  module OrderService
    class OrderItemsCreator
      def initialize(order)
        @order = order
        @user = order.user
      end

      def call
        OrderItem.where(user: @user, ordered: false).each do |item|
          item.update(order: @order, ordered: true)
        end
      end
    end
  end
end
