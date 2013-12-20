class RemoveWinnerFromRestaurants < ActiveRecord::Migration
  def change
  	remove_column :restaurants, :winner
  end
end
