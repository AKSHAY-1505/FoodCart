module ApplicationHelper
  def render_delivery_time_estimation(order)
    return '' unless order.order_delivery_agent&.delivered_at

    difference = distance_of_time_in_words(order.order_delivery_agent.assigned_at,
                                           order.order_delivery_agent.delivered_at)
    "<p>Order Delivered in <strong>#{difference}</strong></p>".html_safe
  end
end
