class AddAddressToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :house_number, :string
    add_column :customers, :street, :string
    add_column :customers, :locality, :string
    add_column :customers, :city, :string
    add_column :customers, :phone_number, :integer
  end
end
