class ModifyOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :food_id, :bigint
    add_column :order_items, :food_name, :string
    add_column :order_items, :food_price, :integer
  end
end
