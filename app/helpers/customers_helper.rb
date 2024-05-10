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
end
