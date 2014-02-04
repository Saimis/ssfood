module UsersHelper
  def voted_users
    @voted_users = Userarchives.where(['voted_for > 0 AND archives_id = :id', {id: Archives.last.id}]).count
  end

  def current_round_userarchive 
  	@current_round_userarchive = Userarchives.where(:user_id => current_user.id, :archives_id => current_round.id).first
  end
end
