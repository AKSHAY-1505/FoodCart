class RenameFromAndToColumnsInPromotions < ActiveRecord::Migration[7.1]
  def change
    rename_column :promotions, :from, :from_date
    rename_column :promotions, :to, :to_date
  end
end
