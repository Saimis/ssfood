class RenameArchyvesToOrders < ActiveRecord::Migration
  def up
    rename_table :archyves, :orders
  end

  def down
    rename_table :orders, :archyves
  end
end
