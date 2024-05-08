class RemoveCustomerIdFromAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :customer_id
  end
end
