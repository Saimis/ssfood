module UsersHelper
  def voted_users
    @voted_users = OrderUser
      .with_restaurant
      .where(archyves_id: Archyves.last.id)
      .count
  end

  def current_round_order_user
    @current_round_order_user ||= OrderUser.where(
      user_id: current_user.try(:id),
      archyves_id: current_round.try(:id)).first
  end

  def user_last_food(user_id)
    OrderUser.joins(:archyves)
      .where.not(food: nil)
      .where(user_id: user_id)
      .where(archyves: { restaurant_id: current_round.restaurant_id })
      .order(id: :desc).first.try(:food) || 'Dienos pietūs'
  end
end
