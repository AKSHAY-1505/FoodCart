class AddAddressToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :address, foreign_key: true
  end
end
