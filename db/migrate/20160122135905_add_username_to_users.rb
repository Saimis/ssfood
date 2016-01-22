class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string

    User.find_each do |user|
      user.username = user.name
      user.save
    end
  end

  def down
    remove_column :users, :username
  end
end
