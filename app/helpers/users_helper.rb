module UsersHelper
  def voted_users
    @voted_users = User.where(voted: true).count
  end

  def current_round_userarchyve 
  	@current_round_userarchyve = Userarchyves.where(:user_id => current_user.id, :archyves_id => current_round.id).first
  end
end
