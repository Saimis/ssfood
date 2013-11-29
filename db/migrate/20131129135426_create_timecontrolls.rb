class CreateTimecontrolls < ActiveRecord::Migration
  def change
    create_table :timecontrolls do |t|
      t.string :start
      t.string :end
      t.string :gap

      t.timestamps
    end
  end
end
