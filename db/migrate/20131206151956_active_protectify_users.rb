class ActiveProtectifyUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    User.all.each do |u|
      u.password_confirmation = u.password
      u.save
    end
  end
end
