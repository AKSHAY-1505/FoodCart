class CreateOrderDeliveryAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :order_delivery_agents do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :assigned_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
