class RemoveAddressAndPhoneFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :house_number, :string
    remove_column :customers, :street, :string
    remove_column :customers, :locality, :string
    remove_column :customers, :city, :string
    remove_column :customers, :phone_number, :integer
  end
end
