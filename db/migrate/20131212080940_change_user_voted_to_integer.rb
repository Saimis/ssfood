class ChangeUserVotedToInteger < ActiveRecord::Migration
  def change
  	change_column :users, :voted, :integer
  end
end
