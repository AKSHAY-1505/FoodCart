class CartsController < ApplicationController
    def show
        @cart = current_customer.cart
        @cart_items = CartItem.where(cart: @cart)

        @subtotal = @cart.total
        @delivery_charge = @subtotal > 500 ? 0 : 30
        @total = @subtotal + @delivery_charge
    end
end