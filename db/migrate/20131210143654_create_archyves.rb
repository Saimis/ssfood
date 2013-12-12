class CreateArchyves < ActiveRecord::Migration
  def change
    create_table :archyves do |t|
      t.datetime :date
      t.integer :restaurant_id
      t.integer :caller

      t.timestamps
    end
  end
end
