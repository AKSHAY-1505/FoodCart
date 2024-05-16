module CustomersHelper
  def render_suggestion_accrodian
    yield if user_is_customer?
  end

  def render_category(category)
    yield if category.foods.count > 0
  end

  def render_order_placed_status_bar(order)
    yield if order.status == 'order_placed'
  end

  def render_agent_assigned_status_bar(order)
    yield if order.status == 'delivery_agent_assigned'
  end

  def render_out_for_delivery_status_bar(order)
    yield if order.status == 'out_for_delivery'
  end

  def render_order_tracking_modal(order)
    yield if order.is_active
  end

  def render_out_of_stock_warning(food)
    yield if food.quantity == 0
  end

  def render_quantity_selector(food)
    yield if food.quantity > 0
  end

  def display_food_image(food)
    yield if food.images.any?
  end

  def display_customer_past_orders(past_orders)
    yield if past_orders.any?
  end

  def display_customer_active_orders(active_orders)
    yield if active_orders.any?
  end
end
