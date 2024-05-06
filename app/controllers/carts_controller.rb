class CartsController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :set_cart, only: %i[show apply_coupon remove_coupon]

  def show
    @cart_items = CartItem.where(cart: @cart)
    Services::CartHelper::CartDiscountApplier.new(@cart).call # To apply best discounts available at the moment
  end

  def apply_coupon
    result = @cart.apply_coupon(params[:coupon_code])

    if result[:notice]
      render partial: 'carts/cart_summary', locals: { cart: @cart }, status: :ok
    else
      render json: { message: result[:alert] }, status: :ok
    end
  end

  def remove_coupon
    Services::CartHelper::CartCouponRemover.new(@cart).call
    render partial: 'carts/cart_summary', locals: { cart: @cart }, status: :ok
  end

  private

  def authenticate_user
    return if params[:id].to_i == current_customer.cart.id

    redirect_to root_path, alert: 'Error! You are not authorized to visit this page'
  end

  def set_cart
    @cart = current_customer.cart
  end
end
