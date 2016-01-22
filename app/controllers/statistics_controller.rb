class StatisticsController < ApplicationController
  def index
    @restaurants_win = restaurants_win_data
    @users_votes_data = users_votes_data
    @users_food_data = users_food_data
    @users_callers_data = users_callers_data
  end

  private

  def restaurants_win_data
    restaurants = Restaurant.all
    restaurants_data = []
    restaurants.map { |r| restaurants_data.push([ r.name, Order.where(restaurant_id: r.id).count ]) }
    restaurants_data
  end

  def users_callers_data
    users_data = []
    users.map { |u| users_data.push([ u.name, Order.where(caller_id: u.id).count ]) }
    users_data
  end

  def users_votes_data
    users_data = []
    users.map { |u| users_data.push([ u.name, counter(u.id) ]) }
    users_data
  end

  def users_food_data
    users_data = []
    users.map { |u| users_data.push([u.name, counter(u.id)]) }
    users_data
  end

  def counter(uid)
    OrderUser.where(user_id: uid).where('food IS NOT NULL').count
  end

  def users
    @users ||= User.without_admins
  end
end
