class CartItemsController < ApplicationController

    def create
        cart_id = current_customer.cart.id
        item_in_cart = item_present_in_cart(cart_id,params[:food_id])

        if item_in_cart.any?
            @cart_item = item_in_cart.first
            @cart_item.quantity += params[:quantity].to_i 
        else
            @cart_item = CartItem.new(quantity: params[:quantity],food_id: params[:food_id],cart_id: cart_id)
        end

        if @cart_item.save
            update_cart_total(cart_id,params[:food_id],params[:quantity])
            render json: { message: 'Item added to cart successfully.', cart_quantity: cart_items_count }, status: :created
        else
            render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
        end
    end


    private 

    def cart_items_count
        CartItem.where(cart: current_customer.cart).count
    end

    def item_present_in_cart(cart_id,food_id)
        CartItem.where(cart_id: cart_id, food_id: food_id)
    end

    def update_cart_total(cart_id,food_id,quantity)
        cart = Cart.find(cart_id)
        food = Food.find(food_id)
        amount = food.price * quantity.to_i
        cart.total += amount
        cart.save
    end

end