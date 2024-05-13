class ApplicationController < ActionController::Base
  helper_method :user_is_customer?, :user_is_admin?, :user_is_delivery_agent?, :delivery_address,
                :delivery_agent_role_id

  # CART_TOTAL_CALCULATOR_CLASS = Services::CartService::CartTotalCalculator
  # CART_DISCOUNT_APPLIER_CLASS = Services::CartService::CartDiscountApplier
  # FOOD_SUGGESTION_CLASS = Services::CustomerService::FoodSuggestion
  # CART_ITEM_CREATOR_CLASS = Services::CartItemService::CartItemCreator

  # ADMIN_ROLE_ID = Role.find_by(name: 'Admin')
  # CUSTOMER_ROLE_ID = Role.find_by(name: 'Customer')

  def user_is_customer?
    current_user.role.name == 'Customer' if current_user
  end

  def user_is_admin?
    current_user.role.name == 'Admin' if current_user
  end

  def user_is_delivery_agent?
    current_user.role.name == 'Delivery Agent' if current_user
  end

  # Returns delivery address for an address record
  def delivery_address(address)
    [address.house_number, address.street_name, address.locality, address.city].join(',')
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorised to access this page!' unless user_is_admin?
  end

  def authenticate_customer
    redirect_to root_path, alert: 'Error! You are not authorized to visit this page' unless user_is_customer?
  end

  def authenticate_delivery_agent
    redirect_to root_path, alert: 'You are not authorized to visit that page!' unless user_is_delivery_agent?
  end

  def delivery_agent_role_id
    Role.find_by(name: 'Delivery Agent').id
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
