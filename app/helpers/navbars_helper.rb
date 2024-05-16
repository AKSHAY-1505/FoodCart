module NavbarsHelper
  def display_admin_buttons
    yield if user_is_admin?
  end

  def display_customer_buttons
    yield if user_is_customer?
  end

  def display_signed_out_buttons
    yield unless user_signed_in?
  end
end
