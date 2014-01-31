class AddUsersVotedColumn < ActiveRecord::Migration
  def change
  	add_column :users, :voted, :integer
  end
end
