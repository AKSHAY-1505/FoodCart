class AddUserIdToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :user, null: false, foreign_key: true
  end
end
