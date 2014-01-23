class AdminController < ApplicationController
	before_action :admin_check

	def admin_check 
		if current_user.name != 'admin'
			redirect_to root_path
		end
	end

	def index
		@archyve_last_date = Archyves.last.date
		@users = User.all
	end

	def start
    if current_user.name == 'admin'
    	
      User.update_all(:food => nil)
      Restaurant.update_all(:votes => 0)
      archyve = Archyves.create :date => Time.now + 600
      User.all().each do |user|
        Userarchyves.create :user_id => user.id, :archyves_id => archyve.id
      end
    end
    redirect_to admin_url
  end
end
