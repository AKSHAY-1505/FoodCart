class CartItemsController < ApplicationController

    def create
        cart_item = create_or_update_cart_item

        if cart_item.save
            render json: { message: 'Item added to cart successfully.' }, status: :created
        else
            render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
        end
    end


    def destroy
        cart_item = CartItem.find(params[:id])

        if cart_item.destroy!
            render json: { message: 'Item removed from cart successfully.', total: current_customer.cart.total }, status: :created
        else
            render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
        end
    end


    private 

    def create_or_update_cart_item
        cart = current_customer.cart
        quantity = params[:quantity].to_i
        food_id = params[:food_id]

        item_in_cart = CartItem.where(cart: cart, food_id: food_id)

        if item_in_cart.any?
            cart_item = item_in_cart.first
            cart_item.quantity += quantity
            update_cart_total(cart,cart_item,quantity)
        else
            cart_item = CartItem.new(quantity: quantity,food_id: food_id,cart: cart)
        end

        cart_item
    end

    def update_cart_total(cart,cart_item, quantity)
        amount = quantity * cart_item.food.price
        cart.total += amount
        cart.save
    end
end