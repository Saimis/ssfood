class AddLastfoodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastfood, :string
  end
end
