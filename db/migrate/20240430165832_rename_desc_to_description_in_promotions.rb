class RenameDescToDescriptionInPromotions < ActiveRecord::Migration[7.1]
  def change
    rename_column :promotions, :desc, :description
  end
end
