class RenameTotalToSubtotalInCarts < ActiveRecord::Migration[7.1]
  def change
    rename_column :carts, :total, :subtotal
  end
end
