class CartsController < ApplicationController
  before_action :authenticate_user

  def show
    cart = current_customer.cart
    @cart_items = CartItem.where(cart:)

    @subtotal = cart.total
    @delivery_charge = @subtotal > 500 ? 0 : 30
    @total = @subtotal + @delivery_charge
  end

  private

  def authenticate_user
    return if params[:id].to_i == current_customer.cart.id

    redirect_to root_path,
                alert: 'Error! You are not authorized to visit this page'
  end
end
