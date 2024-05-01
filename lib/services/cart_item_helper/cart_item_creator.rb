module Services
  module CartItemHelper
    class CartItemCreator
      def initialize(cart, food_id, quantity)
        @cart = cart
        @food = Food.find(food_id)
        @quantity = quantity.to_i
      end

      def call
        item_in_cart = CartItem.where(cart: @cart, food: @food).first
        if item_in_cart.present?
          item_in_cart.quantity += @quantity
          item_in_cart.subtotal = @food.price * item_in_cart.quantity
          # item_in_cart.discount = Services::CartItemHelper::DiscountCalculator.new(item_in_cart).call
          item_in_cart
        else
          subtotal = @food.price * @quantity
          item = CartItem.new(cart: @cart, food: @food, quantity: @quantity, subtotal: subtotal)
          # item.discount = Services::CartItemHelper::DiscountCalculator.new(item).call
          item
        end
      end
    end
  end
end
