class RemoveAgainUsersVotedColumn < ActiveRecord::Migration
  def change
  	remove_column :users, :voted
  end
end
