class RenameUserarchyvesTable < ActiveRecord::Migration
  def up
    rename_table :userarchyves, :order_users
  end

  def down
    rename_table :order_users, :userarchyves
  end
end
