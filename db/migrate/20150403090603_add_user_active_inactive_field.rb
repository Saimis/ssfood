class AddUserActiveInactiveField < ActiveRecord::Migration
  def change
    add_column :users, :disabled, :integer, false
  end
end
