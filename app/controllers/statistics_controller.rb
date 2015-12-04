class StatisticsController < ApplicationController
  before_action :authenticate_admin!, only: :amount

  def index
    @restaurants_win = restaurants_win_data
    @users_votes_data = users_votes_data
    @users_food_data = users_food_data
    @users_callers_data = users_callers_data
  end

  def restaurants_win_data
    restaurants = Restaurant.all
    restaurants_data = []
    restaurants.map { |r| restaurants_data.push([ r.name, Archyves.where(restaurant_id: r.id).count ]) }
    restaurants_data
  end

  def users_callers_data
    users_data = []
    users.map { |u| users_data.push([ u.name, Archyves.where(caller: u.id).count ]) }
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
    Userarchyves.where(user_id: uid).where('food IS NOT NULL').count
  end

  def users
    @users ||= User.where("name != 'admin'")
  end

  def amount
    admin = User.where(name: 'admin').first
    @users_list = User.where("name != 'admin'").where(disabled: 0).select(:id, :name, :lastname).index_by(&:id)
    @userarchyves = Userarchyves.where(archyves_id: Archyves.last.id).where('user_id != ?', admin.id)
    @total = @userarchyves.sum(:sum)
  end
end
