class ApplicationController < ActionController::Base
  helper_method :current_customer, :delivery_address

  # Return the currently logged in customer
  def current_customer
    return unless current_user&.customer?

    current_user.customer
  end

  # Returns delivery address for an order
  def delivery_address(address)
    [address.house_number, address.street_name, address.locality, address.city].join(',')
  end

  private

  # Override devise method
  def after_sign_in_path_for(user)
    if user.admin?
      admin_home_path
    elsif user.delivery_agent?
      delivery_agent_home_path
    else
      root_path
    end
  end
end
