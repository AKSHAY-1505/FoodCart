module Services
  module CartItemService
    class CartItemCreator
      def initialize(user, food_id, quantity)
        @user = user
        @food = Food.find(food_id)
        @quantity = quantity.to_i
      end

      def create_cart_item
        item_in_cart = OrderItem.where(user: @user, food: @food, ordered: false).first
        if item_in_cart.present?
          item_in_cart.quantity += @quantity
          item_in_cart.subtotal = @food.price * item_in_cart.quantity
          item_in_cart
        else
          subtotal = @food.price * @quantity
          OrderItem.new(user: @user, food: @food, quantity: @quantity, subtotal: subtotal)
        end
      end
    end
  end
end
