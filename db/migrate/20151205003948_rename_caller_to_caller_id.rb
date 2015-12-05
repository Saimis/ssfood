class RenameCallerToCallerId < ActiveRecord::Migration
  def up
    rename_column :orders, :caller, :caller_id
  end

  def down
    rename_column :orders, :caller_id, :caller
  end
end
