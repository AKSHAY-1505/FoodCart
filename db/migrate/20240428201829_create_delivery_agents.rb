class CreateDeliveryAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_agents do |t|

      t.timestamps
    end
  end
end
