class DropCartsAndCartItemsTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :cart_items
    drop_table :carts
  end
end
