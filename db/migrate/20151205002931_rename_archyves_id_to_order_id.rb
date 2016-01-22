class RenameArchyvesIdToOrderId < ActiveRecord::Migration
  def up
    rename_column :order_users, :archyves_id, :order_id
  end

  def down
    rename_column :order_users, :order_id, :archyves_id
  end
end
