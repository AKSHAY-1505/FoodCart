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

    if cart_item.destroy
      cart = current_customer.cart
      render json: { subtotal: cart.subtotal, delivery_charge: cart.delivery_charge, discount: cart.discount, total: cart.total },
             status: :created
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :food_id).merge(cart_id: current_customer.cart.id)
  end
end
