class CustomersController < ApplicationController
  def update
    @customer = Customer.find_by(user: current_user)
    if @customer.update(customer_edit_params)
      redirect_to edit_user_registration_path, notice: 'Address Updated Successfully'
    else
      redirect_to edit_user_registration_path, alert: @customer.errors.full_messages.join(', ')
    end
  end

  def home
    @categories = Category.all
  end

  def customer_orders
    @active_orders = current_customer.orders.where(is_active: true)
    @past_orders = current_customer.orders.where(is_active: false)
  end

  private

  def customer_edit_params
    params.require(:customer).permit(:house_number, :street, :locality, :city, :phone_number)
  end
end
