class AddDeliveryAgentIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :delivery_agent, foreign_key: true
  end
end
