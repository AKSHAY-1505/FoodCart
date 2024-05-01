class AddSubtotalAndDiscountToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :subtotal, :integer
    add_column :cart_items, :discount, :integer
  end
end
