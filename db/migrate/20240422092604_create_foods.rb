class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :quantity
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
