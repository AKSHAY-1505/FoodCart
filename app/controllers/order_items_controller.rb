class OrderItemsController < ApplicationController
  def create
    order_item = cart_item_creator_class.new(current_user, order_item_params[:food_id],
                                             order_item_params[:quantity]).create_cart_item
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

  def cart_item_creator_class
    Services::CartItemService::CartItemCreator
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :food_id)
  end

  def collect_cart_details
    Services::CartService::CartTotalCalculator.new(current_user).calculate_total
  end
end
