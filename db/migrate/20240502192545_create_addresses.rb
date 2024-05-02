class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :street_name
      t.string :locality
      t.string :city
      t.string :phone_number
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
