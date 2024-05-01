class ChangeDiscountPercentageToIntegerInPromotions < ActiveRecord::Migration[7.1]
  def change
    change_column :promotions, :discount_percentage, :integer
  end
end
