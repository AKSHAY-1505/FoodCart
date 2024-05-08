class RemoveDeliveryAgentIdFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :delivery_agent_id
  end
end
