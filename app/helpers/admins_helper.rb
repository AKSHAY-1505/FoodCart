module AdminsHelper
  def render_delivery_agent_name(order)
    yield if order.order_delivery_agent.present?
  end

  def render_assign_agent_model(order)
    yield unless order.order_delivery_agent
  end
end
