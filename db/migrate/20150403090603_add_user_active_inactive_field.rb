class AddUserActiveInactiveField < ActiveRecord::Migration
  def change
    add_column :users, :disabled, :integer, default: false
  end
end
