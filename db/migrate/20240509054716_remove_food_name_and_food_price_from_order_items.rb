class RemoveFoodNameAndFoodPriceFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :food_name, :string
    remove_column :order_items, :food_price, :integer
  end
end
