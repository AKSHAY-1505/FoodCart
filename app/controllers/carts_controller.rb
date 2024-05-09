class CartsController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :set_user, only: %i[show apply_coupon remove_coupon]

  def show
    # @cart_items = CartItem.where(cart: @cart)
    @cart_items = OrderItem.where(user: @user, ordered: false)
    Services::CartHelper::CartDiscountApplier.new(@cart_items).call # To apply best discounts available at the moment
    @cart_details = Services::CartHelper::CartTotalCalculator.new(current_user).call
  end

  def apply_coupon
    @cart_details = Services::CartHelper::CartTotalCalculator.new(current_user, params[:code]).call

    if @cart_details[:coupon_discount] > 0 # rubocop:disable Style/NumericPredicate
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :ok
    else
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :unprocessable_entity
    end
  end

  def remove_coupon
    Services::CartHelper::CartCouponRemover.new(@cart).call
    render partial: 'carts/cart_summary', locals: { cart: @cart }, status: :ok
  end

  private

  def authenticate_user
    return if params[:id].to_i == current_user.id

    redirect_to root_path, alert: 'Error! You are not authorized to visit this page'
  end

  def set_user
    @user = current_user
  end
end
