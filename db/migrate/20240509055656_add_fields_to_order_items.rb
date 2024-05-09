class AddFieldsToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :subtotal, :integer
    add_column :order_items, :discount, :integer, default: 0
  end
end
