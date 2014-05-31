class AdminController < ApplicationController
  before_action :admin_check

  def admin_check 
    if current_user.nil? || current_user.name != 'admin'
      redirect_to root_path
    end
  end

  def index
    @archyve = Archyves.last
    @users = User.order('name').all
    @archyves = Archyves.all 
    @userarchyves = Userarchyves
                      .where(archyves_id: @archyves.last.id)
                      .order('archyves_id').all
    @restaurants = Restaurant.all
  end

  def start
    User.update_all(food: nil)
    Restaurant.update_all(votes: 0)
    time_gap = 120
    food_time_gap = 240
    archyve = Archyves.create(
      date: Time.now + time_gap, 
      food_time: Time.now + time_gap + food_time_gap, 
      caller: select_caller.id)
    
    User.all.each do |user|
      Userarchyves.create(user_id: user.id, archyves_id: archyve.id)
    end
  end

  def select_caller
    last_caller = Archyves.last.nil? ? 0 : Archyves.last.caller
    last_caller = User.where("id > ?", last_caller).where("name != 'admin'").first
    last_caller ||= User.first
  end
end
