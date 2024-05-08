class RemoveCustomerIdFromCarts < ActiveRecord::Migration[7.1]
  def change
    remove_column :carts, :customer_id
  end
end
