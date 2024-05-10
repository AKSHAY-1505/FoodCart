class CustomersController < ApplicationController
  FOOD_SUGGESTION_CLASS = Services::CustomerService::FoodSuggestion

  def home
    @categories = Category.includes(:foods).all # To Prevent N+1 queries
    @suggested_foods = FOOD_SUGGESTION_CLASS.new(current_user).call if user_signed_in?
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
