class AddRememberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember, :string
    add_index :users, :remember
  end
end
