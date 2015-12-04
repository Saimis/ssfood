class StatisticsController < ApplicationController
  before_action :authenticate_admin!, only: :amount

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
    @users ||= User.without_admins
  end

  def amount
    @users_list = User.without_admins.enabled.select(:id, :name, :lastname)
      .index_by(&:id)
    @userarchyves = user_archives
    @total = @userarchyves.sum(:sum)
  end

  def user_archives
    last_archive = Archyves.last
    return [] unless last_archive
    admin = User.where(name: 'admin').first
    Userarchyves.where(archyves_id: last_archive.id)
      .where.not(user_id: admin.id)
  end
end
