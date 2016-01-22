class RenameVotedForColumnToRestaurantId < ActiveRecord::Migration
  def up
    rename_column :order_users, :voted_for, :restaurant_id
  end

  def down
    rename_column :order_users, :restaurant_id, :voted_for
  end
end
