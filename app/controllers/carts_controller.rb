class CartsController < ApplicationController
  before_action :authenticate_user

  def show
    @cart = current_customer.cart
    @cart_items = CartItem.where(cart: @cart)
    Services::CartHelper::CartDiscountApplier.new(@cart).call # To apply best discounts available at the moment
  end

  def checkout
    @address = Address.new
    @addresses = Address.where(customer: current_customer)
  end

  private

  def authenticate_user
    return if params[:id].to_i == current_customer.cart.id

    redirect_to root_path, alert: 'Error! You are not authorized to visit this page'
  end
end
