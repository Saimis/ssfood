class MainController < ApplicationController
  attr_accessor :current_round

  def index
    @restaurants = Restaurant.order(:name).all
    @users = User.without_admins.enabled.order(:name).all

    if current_round
      @restaurant_time = current_round.date.asctime.to_s
      @food_time = current_round.food_datetime.asctime.to_s
    end
  end

  #the main information source for long poller, returns all information about users and restaurants
  def get_data
    users_without_admin = User.without_admins.enabled.count
    users = OrderUser.select(:user_id, :food, :sum, :restaurant_id)
      .where(order_id: current_round.id).all
    retaurants = Restaurant.select(:id, :votes).all
    end_round

    # return json
      render json: {
         users: users.as_json(only: [:user_id, :food, :sum, :voted]),
         restaurants: retaurants.as_json(only: [:id, :votes]),
         winner: winner.as_json(only: [:id]),
         food_history: food_history.as_json(only: [:food]),
         round_end: current_round.complete.as_json
        }
  end

  def end_round
   return unless Time.now > current_round.food_datetime or can_end_round?
   round = current_round
   round.complete = true
   round.save
   render json: { ended: true } if params[:force_end_round]
  end

  def can_end_round?
    current_user and current_user.id == current_round.caller_id and
    (Time.now > current_round.date or current_round.restaurant_id) and params[:force_end_round]
  end

  def food_history
    return {} unless current_round.restaurant_id && current_user
    OrderUser.joins(:order)
      .where(user_id: current_user.id)
      .where(orders: { restaurant_id: current_round.restaurant_id })
      .order(id: :desc)
  end

  def voting_ended?
    users_without_admin = User.without_admins.count
    current_round.restaurant_id.nil? &&
      (voted_users >= users_without_admin || Time.now > current_round.date.to_datetime)
  end

  def winner
    save_winner if voting_ended?
    if current_round.restaurant_id
      Restaurant.find(current_round.restaurant_id)
    else
      {}
    end
  end

  def save_winner
    round = current_round
    round.restaurant_id = Restaurant.order("votes DESC, RANDOM()").first.try(:id)
    round.save
  end

  def voted_users
    @voted_users = OrderUser.with_restaurant.where(order_id: current_round.id).count
  end

  def current_round
    @current_round ||= Order.last
  end

  def create_popup
    @restaurants = Restaurant.order(:name).all
    @users = User.without_admins.enabled.order(:name).all
  end
end
