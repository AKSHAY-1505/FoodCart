class CustomersController < ApplicationController
  def update
    @customer = current_customer.user
    if @customer.update(customer_edit_params)
      redirect_to edit_user_registration_path, notice: 'Address Updated Successfully'
    else
      redirect_to edit_user_registration_path, alert: @customer.errors.full_messages.join(', ')
    end
  end

  def home
    @categories = Category.all
    # @suggested_foods = Services::CustomerService::FoodSuggestion.new(current_user).call if user_signed_in?
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
