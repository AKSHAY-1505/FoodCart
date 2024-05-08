class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :role, foreign_key: true, default: 3
  end
end
