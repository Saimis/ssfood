class AddWinnerFieldToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :winner, :datetime
  end
end
