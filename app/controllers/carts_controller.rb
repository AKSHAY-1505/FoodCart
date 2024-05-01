class CartsController < ApplicationController
  before_action :authenticate_user

  def show
    @cart = current_customer.cart
    @cart_items = CartItem.where(cart: @cart)
    Services::Cart::CartDiscountApplier.new(@cart).call # To apply best discounts available at the moment
  end

  private

  def authenticate_user
    return if params[:id].to_i == current_customer.cart.id

    redirect_to root_path, alert: 'Error! You are not authorized to visit this page'
  end
end
