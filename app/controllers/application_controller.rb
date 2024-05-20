class ApplicationController < ActionController::Base
  helper_method :user_is_customer?, :user_is_admin?, :user_is_delivery_agent?, :delivery_address,
                :cart_count

  def user_is_customer?
    current_user.role.name == 'Customer' if current_user
  end

  def user_is_admin?
    current_user.role.name == 'Admin' if current_user
  end

  def user_is_delivery_agent?
    current_user.role.name == 'Delivery Agent' if current_user
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorised to access this page!' unless user_is_admin?
  end

  def authenticate_customer
    return if user_is_customer?

    redirect_to root_path, alert: 'Error! You are not authorized to visit this page', status: :unauthorized
  end

  def authenticate_delivery_agent
    redirect_to root_path, alert: 'You are not authorized to visit that page!' unless user_is_delivery_agent?
  end

  # Returns delivery address for an address record
  def delivery_address(address)
    [address.house_number, address.street_name, address.locality, address.city].join(',')
  end

  # returns cart count for current user
  def cart_count
    OrderItem.where(user: current_user, ordered: false).count
  end

  private

  # Override devise method
  def after_sign_in_path_for(user)
    if user_is_admin?
      admin_home_path
    elsif user_is_delivery_agent?
      delivery_agent_home_path
    else
      root_path
    end
  end
end
