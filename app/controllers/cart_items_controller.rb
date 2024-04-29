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
      render json: { total: current_customer.cart.total }, status: :created
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
    end
  end

  private

  def create_or_update_cart_item
    item_in_cart = CartItem.where(cart: current_customer.cart, food_id: params[:food_id]).first

    if item_in_cart
      item_in_cart.quantity += params[:quantity].to_i
      item_in_cart
    else
      CartItem.new(quantity: params[:quantity].to_i, food_id: params[:food_id], cart: current_customer.cart)
    end
  end
end
