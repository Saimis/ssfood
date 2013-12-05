class AddPhoneFieldToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :phone, :string
  end
end
