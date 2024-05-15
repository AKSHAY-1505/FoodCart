module Services
  module CartItemService
    class CartItemCreator
      def initialize(user, food_id, quantity, food_class = Food, order_item_class = OrderItem)
        @user = user
        @food = food_class.find(food_id)
        @quantity = quantity.to_i
        @order_item_class = order_item_class
      end

      def mini_test_helper
        
      end

      def create_cart_item
        item_in_cart = @order_item_class.find_or_initialize_by({ user: @user, food: @food, ordered: false })
        if item_in_cart.quantity #0
          item_in_cart.quantity += @quantity
        else
          item_in_cart.quantity = @quantity
        end
        item_in_cart.subtotal = @food.price * item_in_cart.quantity
        decrease_food_stock
        item_in_cart
      end

      def decrease_food_stock
        previous_quantity = @food.quantity
        # debugger
        new_quantity = previous_quantity - @quantity
        @food.update({ quantity: new_quantity })
      end
    end
  end
end
