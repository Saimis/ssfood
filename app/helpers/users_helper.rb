module UsersHelper
  def voted_users
    @voted_users = Userarchyves.where(['voted_for > 0 AND archyves_id = :id', {id: Archyves.last.id}]).count
  end

  def current_round_userarchyve 
  	@current_round_userarchyve = Userarchyves.where(:user_id => current_user.id, :archyves_id => current_round.id).first
  end
end
