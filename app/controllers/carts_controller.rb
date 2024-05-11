class CartsController < ApplicationController
  before_action :authenticate_customer, only: [:show]
  before_action :set_user, only: %i[show apply_coupon]



  def show
    @cart_items = OrderItem.where(user: @user, ordered: false)
    CART_DISCOUNT_APPLIER_CLASS.new(@cart_items).apply_discount # To apply best discounts available at the moment
    @cart_details = CART_TOTAL_CALCULATOR_CLASS.new(@user).calculate_total
  end

  def apply_coupon
    @cart_details = CART_TOTAL_CALCULATOR_CLASS.new(@user, params[:code]).calculate_total

    if @cart_details[:coupon_discount] > 0 # rubocop:disable Style/NumericPredicate
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :ok
    else
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end
end
