class RestaurantsController < ApplicationController
  def vote
    if can_vote?
      user = User.where(remember: cookies[:remember]).first
      if user
        restaurant = Restaurant.find(params[:id])
        order_user = OrderUser.where(user_id: user.id, order_id: current_round.id).first_or_create

        if order_user.restaurant_id.nil? && params[:act].nil?
          restaurant.increment(:votes, 1)
          order_user.restaurant_id = params[:id]
        elsif order_user.restaurant_id && params[:act].present?
          restaurant.decrement(:votes, 1)
          order_user.restaurant_id = nil
        end
        restaurant.save
        order_user.save
      end
    end
    redirect_to root_path
  end

  private

  def current_round
    @last_order ||= Order.last
  end

  def voted_users_count
    @voted_users_count ||= OrderUser
      .with_restaurant.where(order_id: current_round.id).count
  end

  def can_vote?
    users_without_admins_count = User.without_admins.count

    current_user &&
      Time.zone.now < current_round.date.to_datetime &&
      voted_users_count <= users_without_admins_count &&
      params[:id].present?
  end
end
