class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :total, default: 0

      t.timestamps
    end
  end
end
