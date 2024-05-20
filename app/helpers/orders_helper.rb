module OrdersHelper
  def time_estimation(order)
    distance_of_time_in_words(order.order_delivery_agent.assigned_at, order.order_delivery_agent.delivered_at)
  end

  def delivery_time_estimation(order)
    yield unless order.is_active
  end

  # with_deleted method by paranoia gem to include soft-deleted records in query result
  def find_food(id)
    Food.with_deleted.find(id)
  end
end
