module UsersHelper
  def voted_users
    @voted_users = User.where(voted: true).count
  end
end
