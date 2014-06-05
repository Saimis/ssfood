module UsersHelper
  def voted_users
    @voted_users = Userarchyves.where("voted_for > 0 AND archyves_id = ?", Archyves.last.id).count
  end

  def current_round_userarchyve 
    	@current_round_userarchyve = Userarchyves.where(
    		user_id: current_user.try(:id), 
    		archyves_id: current_round.try(:id)).first
  end

  def user_last_food(user_id)
	  Userarchyves.joins(:archyves)
      .where("userarchyves.food NOT NULL and userarchyves.user_id = ?", user_id)
      .where("archyves.restaurant_id = ?", current_round.restaurant_id)
      .order("userarchyves.id DESC").first.try(:food) || "Dienos pietūs"
  end
end
