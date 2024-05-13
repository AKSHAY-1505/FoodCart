class CustomersController < ApplicationController
  before_action :authenticate_customer, only: %i[customer_orders]
  def home
    @categories = Category.includes(:foods).all # To Prevent N+1 queries
    @suggested_foods = food_suggestion_class.new(current_user).suggested_foods if user_signed_in?
  end

  def view_food
    @food = Food.find(params[:id])
  end

  def customer_orders
    @active_orders = current_user.orders.where(is_active: true)
    @past_orders = current_user.orders.where(is_active: false)
  end

  private

  def food_suggestion_class
    Services::CustomerService::FoodSuggestion
  end

  def customer_edit_params
    params.require(:customer).permit(:house_number, :street, :locality, :city, :phone_number)
  end
end
