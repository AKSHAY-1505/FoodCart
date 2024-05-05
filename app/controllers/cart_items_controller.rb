class CartItemsController < ApplicationController
  def create
    cart_item = Services::CartItemHelper::CartItemCreator.new(current_customer.cart, cart_item_params[:food_id],
                                                              cart_item_params[:quantity]).call

    if cart_item.save
      render json: { message: 'Item added to cart successfully.' }, status: :created
    else
      render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart = cart_item.cart

    if cart_item.destroy
      render partial: 'carts/cart_summary', locals: { cart: cart }, status: :ok
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :food_id).merge(cart_id: current_customer.cart.id)
  end
end
