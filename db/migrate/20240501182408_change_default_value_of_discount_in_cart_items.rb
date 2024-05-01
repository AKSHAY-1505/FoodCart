class ChangeDefaultValueOfDiscountInCartItems < ActiveRecord::Migration[7.1]
  def change
    change_column_default :cart_items, :discount, 0
  end
end
