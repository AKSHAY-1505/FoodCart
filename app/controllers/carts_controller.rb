class CartsController < ApplicationController
  before_action :authenticate_customer, only: [:show]
  before_action :set_user, only: %i[show apply_coupon]
  # remove_coupon

  def show
    @cart_items = OrderItem.where(user: @user, ordered: false)
    Services::CartHelper::CartDiscountApplier.new(@cart_items).call # To apply best discounts available at the moment
    @cart_details = Services::CartHelper::CartTotalCalculator.new(@user).call
  end

  def apply_coupon
    @cart_details = Services::CartHelper::CartTotalCalculator.new(@user, params[:code]).call

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
