class RemoveFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :ip
    remove_column :users, :decided
  end
end
