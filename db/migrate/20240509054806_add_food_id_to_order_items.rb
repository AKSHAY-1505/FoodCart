class AddFoodIdToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :food, foreign_key: { to_table: :foods }
  end
end
