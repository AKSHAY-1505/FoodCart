module AdminsHelper
  def render_delivery_agent_name(order)
    yield if order.order_delivery_agent.present?
  end

  def render_assign_agent_model(order)
    yield unless order.order_delivery_agent
  end

  def display_active_orders(active_orders)
    yield if active_orders.any?
  end

  def display_no_orders_received(active_orders)
    yield if active_orders.none?
  end
end
