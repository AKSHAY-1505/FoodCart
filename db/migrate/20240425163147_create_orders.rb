class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :subtotal
      t.integer :delivery_charge
      t.integer :discount
      t.integer :total
      t.integer :status

      t.timestamps
    end
  end
end
