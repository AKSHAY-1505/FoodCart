class CartItemsController < ApplicationController

    def create
        cart_id = current_customer.cart.id

        if item_present_in_cart?(cart_id,params[:food_id])
            @cart_item = CartItem.where(cart_id: cart_id, food_id: params[:food_id]).first
            @cart_item.quantity += params[:quantity].to_i 
        else
            @cart_item = CartItem.new(quantity: params[:quantity],food_id: params[:food_id],cart_id: cart_id)
        end

        if @cart_item.save
            render json: { message: 'Item added to cart successfully.', cart_quantity: cart_items_count }, status: :created
        else
            render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
        end
    end


    private 

    def cart_items_count
        CartItem.where(cart: current_customer.cart).count
    end

    def item_present_in_cart?(cart_id,food_id)
        CartItem.where(cart_id: cart_id, food_id: food_id).any?
    end

end