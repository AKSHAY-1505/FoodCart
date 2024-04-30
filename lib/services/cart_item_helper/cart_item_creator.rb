module Services
  module CartItemHelper
    class CartItemCreator
      def initialize(cart, food_id, quantity)
        @cart = cart
        @food_id = food_id
        @quantity = quantity.to_i
      end

      def call
        item_in_cart = CartItem.where(cart: @cart, food_id: @food_id).first
        if item_in_cart.present?
          item_in_cart.quantity += @quantity
          item_in_cart
        else
          CartItem.new(cart: @cart, food_id: @food_id, quantity: @quantity)
        end
      end
    end
  end
end
