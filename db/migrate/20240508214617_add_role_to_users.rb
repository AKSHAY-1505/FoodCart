class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :role
    add_reference :users, :role, foreign_key: true, default: 3
  end
end
