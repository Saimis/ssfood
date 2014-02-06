class AdminController < ApplicationController
	before_action :admin_check

	def admin_check 
		if current_user.nil? || current_user.name != 'admin'
			redirect_to root_path
		end
	end

	def index
		@archyve = Archyves.last
		@users = User.all
		@archyves = Archyves.all 
    @userarchyves = Userarchyves.find(:all)
    @restaurants = Restaurant.all
	end

	def edit_last_archyve
		@archyve = Archyves.last
		@archyve.date = params[:archyves][:date]
		@archyve.save
		redirect_to admin_url
	end

	def start
    if current_user.name == 'admin'
      User.update_all(:food => nil)
      Restaurant.update_all(:votes => 0)
      time_gap = params[:time].to_i > 0 ? params[:time].to_i : 1200
      food_time_gap = params[:foodtime].to_i > 0 ? params[:foodtime].to_i : 1200
      archyve = Archyves.create :date => Time.now + time_gap, :food_time => food_time_gap
      User.all().each do |user|
        Userarchyves.create :user_id => user.id, :archyves_id => archyve.id
      end
    end
    redirect_to admin_url
  end
end
