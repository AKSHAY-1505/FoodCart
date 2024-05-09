class AddOrderedToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :ordered, :boolean, default: false
  end
end
