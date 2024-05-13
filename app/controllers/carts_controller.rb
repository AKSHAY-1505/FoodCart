class CartsController < ApplicationController
  before_action :authenticate_cart, only: [:show]
  before_action :set_user, only: %i[show apply_coupon]

  def show
    @cart_items = OrderItem.where(user: @user, ordered: false)
    cart_discount_appplier_class.new(@cart_items).apply_discount # To apply best discounts available at the moment
    @cart_details = cart_total_calculator_class.new(@user).calculate_total
  end

  def apply_coupon
    @cart_details = cart_total_calculator_class.new(@user, params[:code]).calculate_total
    if @cart_details[:coupon_discount] > 0 # rubocop:disable Style/NumericPredicate
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :ok
    else
      render partial: 'carts/cart_summary', locals: { cart_details: @cart_details }, status: :unprocessable_entity
    end
  end

  private

  def cart_discount_appplier_class
    Services::CartService::CartDiscountApplier
  end

  def cart_total_calculator_class
    Services::CartService::CartTotalCalculator
  end

  def set_user
    @user = current_user
  end

  def authenticate_cart
    redirect_to root_path, alert: 'Error! You are not authorized to visit this page' unless params[:id].to_i == current_user&.id # rubocop:disable Style/IfUnlessModifier
  end
end
