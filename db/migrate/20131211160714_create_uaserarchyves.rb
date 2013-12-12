class CreateUaserarchyves < ActiveRecord::Migration
  def change
    create_table :uaserarchyves do |t|
      t.integer :archyves_id
      t.integer :voted_for
      t.string :food
      t.integer :user_id

      t.timestamps
    end
  end
end
