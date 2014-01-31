class RemoveUnusedTables < ActiveRecord::Migration
  def change
  	drop_table :timecontrolls
  	remove_column :restaurants, :waslast
  	remove_column :restaurants, :lastused
  	remove_column :users, :voted
  	remove_column :users, :lastfood
  end
end
