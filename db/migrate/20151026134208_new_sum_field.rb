class NewSumField < ActiveRecord::Migration
  def change
    add_column :users,        :sum, :string
    add_column :userarchyves, :sum, :string
  end
end
