class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :about
      t.integer :votes
      t.boolean :waslast
      t.string :lastused

      t.timestamps
    end
  end
end
