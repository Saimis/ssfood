class RenamePayerAndGcToBetterNames < ActiveRecord::Migration
  def up
    rename_column :orders, :payer, :payer_id
    rename_column :orders, :gc, :garbage_collector_id
  end

  def down
    rename_column :orders, :payer_id, :payer
    rename_column :orders, :garbage_collector_id, :gc
  end
end
