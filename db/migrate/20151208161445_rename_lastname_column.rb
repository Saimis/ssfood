class RenameLastnameColumn < ActiveRecord::Migration
  def up
    rename_column :users, :lastname, :last_name
  end

  def down
    rename_column :users, :last_name, :lastname
  end
end
