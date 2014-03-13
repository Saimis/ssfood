class AdminController < ApplicationController
	before_action :admin_check

	def admin_check 
		if current_user.nil? || current_user.name != 'admin'
			redirect_to root_path
		end
	end

	def index
		@archyve = Archyves.last
		@users = User.find(:all, :order => "name ASC")
		@archyves = Archyves.all 
    @userarchyves = Userarchyves.find(:all, :order => "archyves_id DESC")
    @restaurants = Restaurant.all
	end

	def start
    admin_check
    User.update_all(:food => nil)
    Restaurant.update_all(:votes => 0)
    
    time_gap = params[:time].to_i > 0 ? params[:time].to_i : 1200
    food_time_gap = params[:foodtime].to_i > 0 ? params[:foodtime].to_i : 1200
    archyve = Archyves.create :date => Time.now + time_gap, :food_time => food_time_gap, :caller => get_caller.id
    
    User.all.each do |user|
      Userarchyves.create :user_id => user.id, :archyves_id => archyve.id
    end
    
    redirect_to admin_url
  end

  def get_caller
    last_caller = Archyves.last.nil? ? 0 : Archyves.last.caller
    last_caller = User.where("id > ?", last_caller).where("name != 'admin'").first
    last_caller ||= User.first
  end
end
