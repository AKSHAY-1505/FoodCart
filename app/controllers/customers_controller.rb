class CustomersController < ApplicationController
  def home
    @categories = Category.all
    @suggested_foods = Services::CustomerService::FoodSuggestion.new(current_user).call if user_signed_in?
  end

  def view_food
    @food = Food.find(params[:id])
  end

  def customer_orders
    @active_orders = current_user.orders.where(is_active: true)
    @past_orders = current_user.orders.where(is_active: false)
  end

  private

  def customer_edit_params
    params.require(:customer).permit(:house_number, :street, :locality, :city, :phone_number)
  end
end
