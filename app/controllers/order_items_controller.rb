class OrderItemsController < ApplicationController
  before_action :authenticate_customer
  before_action :set_order_item, only: %i[update destroy]

  def create
    order_item = cart_item_creator_class.new(current_user, order_item_params[:food_id], order_item_params[:quantity]).create_cart_item # rubocop:disable Layout/LineLength
    if order_item.save
      render json: { cart_count: cart_count }, status: :created
    else
      render json: { message: 'Failed to add item to cart.' }, status: :unprocessable_entity
    end
  end

  def update
    if cart_item_updator_class.new(@order_item, order_item_params[:quantity]).update_item_details
      render json: { cart_entry_html: cart_entry_html(@order_item), cart_summary_html: cart_summary_html }, status: :ok
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity

    end
  end

  def destroy
    if @order_item.destroy
      render json: { cart_count: cart_count, cart_summary_html: cart_summary_html }, status: :ok
    else
      render json: { message: 'Failed to remove item from cart.' }, status: :unprocessable_entity
    end
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def cart_item_creator_class
    Services::CartItemService::CartItemCreator
  end

  def cart_item_updator_class
    Services::CartItemService::CartItemUpdator
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :food_id, :id)
  end

  def collect_cart_details
    Services::CartService::CartTotalCalculator.new(current_user).calculate_total
  end

  def cart_summary_html
    render_to_string(partial: 'carts/cart_summary', locals: { cart_details: collect_cart_details })
  end

  def cart_entry_html(order_item)
    render_to_string(partial: 'carts/cart_entry', locals: { item: order_item })
  end
end
