class ApplicationController < ActionController::Base
  helper_method :current_customer, :delivery_address

  # Return the currently logged in customer
  def current_customer
    return unless current_user&.customer?

    current_user.customer
  end

  def delivery_address(order)
    customer = order.customer
    [customer.house_number, customer.street, customer.locality, customer.city].join(',')
  end

  private

  # Override devise method
  def after_sign_in_path_for(user)
    # user.admin? ? admin_home_path : root_path
    if user.admin?
      admin_home_path
    elsif user.delivery_agent?
      delivery_agent_home_path
    else
      root_path
    end
  end
end
