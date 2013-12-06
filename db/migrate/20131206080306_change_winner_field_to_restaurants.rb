class ChangeWinnerFieldToRestaurants < ActiveRecord::Migration
  def change
    change_column :restaurants, :winner, :boolean
  end
end
