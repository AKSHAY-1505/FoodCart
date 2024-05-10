class OrderItemsController < ApplicationController
  CART_ITEM_CREATOR_CLASS = Services::CartItemService::CartItemCreator
  CART_TOTAL_CALCULATOR_CLASS = Services::CartService::CartTotalCalculator

  def create
    order_item = CART_ITEM_CREATOR_CLASS.new(current_user, order_item_params[:food_id],
                                             order_item_params[:quantity]).call
    if order_item.save
      render json: { message: 'Item added to cart successfully.' }, status: :created
    else
      render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    if order_item.destroy
      render partial: 'carts/cart_summary', locals: { cart_details: collect_cart_details }, status: :ok
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :food_id)
  end

  def collect_cart_details
    CART_TOTAL_CALCULATOR_CLASS.new(current_user).call
  end
end
