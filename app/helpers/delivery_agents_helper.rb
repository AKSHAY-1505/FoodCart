module DeliveryAgentsHelper
  def render_out_for_delivery_button(order)
    yield if order.status == 'delivery_agent_assigned'
  end

  def render_delivered_button(order)
    yield if order.status == 'out_for_delivery'
  end
end
