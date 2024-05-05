class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.date :from_date
      t.date :to_date
      t.integer :min_amount
      t.integer :discount

      t.timestamps
    end
  end
end
