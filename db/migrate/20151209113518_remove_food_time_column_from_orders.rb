class RemoveFoodTimeColumnFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :food_time
  end

  def down
    add_column :orders, :food_time, :integer
  end
end
