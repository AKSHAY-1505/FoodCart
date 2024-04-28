class AddUserIdToDeliveryAgents < ActiveRecord::Migration[7.1]
  def change
    add_reference :delivery_agents, :user, foreign_key: true
  end
end
