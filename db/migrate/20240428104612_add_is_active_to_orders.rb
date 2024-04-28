class AddIsActiveToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :is_active, :boolean, default: true
  end
end
