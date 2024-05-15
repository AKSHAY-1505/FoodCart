module Services
  module CartItemService
    class CartItemCreator
      def initialize(user, food_id, quantity)
        @user = user
        @food = Food.find(food_id)
        @quantity = quantity.to_i
      end

      def create_cart_item
        # debugger
        item_in_cart = OrderItem.find_or_initialize_by(user: @user, food: @food, ordered: false)
        if item_in_cart.quantity
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
        @food.update(quantity: previous_quantity - @quantity)
      end
    end
  end
end
