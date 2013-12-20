class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :ip
      t.integer :voted
      t.string :food
      t.boolean :decided

      t.timestamps
    end
  end
end
