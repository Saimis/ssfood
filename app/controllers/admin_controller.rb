class AdminController < ApplicationController
	before_action :admin_check

	def admin_check 
		if current_user.nil? || current_user.name != 'admin'
			redirect_to root_path
		end
	end

	def index
		@archive = Archives.last
		@users = User.all
		@rounds = Archives.all 
    @userarchives = Userarchives.find(:all)
    @restaurants = Restaurant.all
	end

	def edit_last_archyve
		@archive = Archives.last
		@archive.date = params[:archives][:date]
		@archive.save
		redirect_to admin_url
	end

	def start
    if current_user.name == 'admin'
      User.update_all(:food => nil)
      Restaurant.update_all(:votes => 0)
      time_gap = params[:time].to_i > 0 ? params[:time].to_i : 1200
      archive = Archives.create :date => Time.now + time_gap
      User.all().each do |user|
        Userarchives.create :user_id => user.id, :archives_id => archive.id
      end
    end
    redirect_to admin_url
  end
end
