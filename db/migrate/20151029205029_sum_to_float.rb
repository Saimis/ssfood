class SumToFloat < ActiveRecord::Migration
  def change
    remove_column :users,        :sum
    remove_column :userarchyves, :sum
    
    add_column :users,        :sum, :float
    add_column :userarchyves, :sum, :float
  end
end
