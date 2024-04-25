class CartItemsController < ApplicationController

    def create
        cart_id = current_customer.cart.id
        item_in_cart = item_present_in_cart(cart_id,params[:food_id])
        quantity = params[:quantity].to_i

        if item_in_cart.any?
            @cart_item = item_in_cart.first
            @cart_item.quantity += quantity
        else
            @cart_item = CartItem.new(quantity: params[:quantity],food_id: params[:food_id],cart_id: cart_id)
        end

        if @cart_item.save
            increase_cart_total(@cart_item, quantity)
            render json: { message: 'Item added to cart successfully.' }, status: :created
        else
            render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
        end
    end


    def destroy
        cart_item = CartItem.find(params[:cartItemId])

        if cart_item.destroy!
            reduce_cart_total(cart_item)
            render json: { message: 'Item removed from cart successfully.', total: current_customer.cart.total }, status: :created
        else
            render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
        end
    end


    private 

    def cart_items_count
        CartItem.where(cart: current_customer.cart).count
    end

    def item_present_in_cart(cart_id,food_id)
        CartItem.where(cart_id: cart_id, food_id: food_id)
    end

    def increase_cart_total(cart_item, quantity)
        amount = quantity * cart_item.food.price
        cart = current_customer.cart
        cart.total += amount
        cart.save
    end

    def reduce_cart_total(cart_item)
        amount = cart_item.quantity * cart_item.food.price
        cart = current_customer.cart
        cart.total -= amount
        cart.save
    end

end