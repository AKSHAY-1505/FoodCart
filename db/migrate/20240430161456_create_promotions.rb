class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :desc
      t.date :from
      t.date :to
      t.string :discount_percentage
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
