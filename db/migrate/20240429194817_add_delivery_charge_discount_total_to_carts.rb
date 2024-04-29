class AddDeliveryChargeDiscountTotalToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :delivery_charge, :integer, default: 0
    add_column :carts, :discount, :integer, default: 0
    add_column :carts, :total, :integer, default: 0
  end
end
