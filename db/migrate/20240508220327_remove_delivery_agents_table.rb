class RemoveDeliveryAgentsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :delivery_agents
  end
end
