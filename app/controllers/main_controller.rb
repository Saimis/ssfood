class MainController < ApplicationController
  def index
     # if Time.now.wday != 5
	#redirect_to "http://samesyste.com"
    #  end
      @user =User.find_by_remember(cookies[:remember]) #User.where(:remember => cookies[:remember])
      @restaurants = Restaurant.all
      @ip = request.remote_ip
      @users = User.all
  end
  
  def choosefood
     @user = User.where(:remember => cookies[:remember]).first
     @food = @user.food  
  end
  
  def savefood 
     user = User.where(:remember => cookies[:remember]).first
     if !user.nil?
      user.food = params[:food]
      user.save
      redirect_to root_path
     end
  end
  
  def dovote
      user = User.where(:remember => cookies[:remember])
      if !user.first.nil? && user.first.voted != true && Time.now.hour < 2 || voted_users < 11
        restaurant = Restaurant.find(params[:id])
	restaurant.increment(:votes, by = 1)
	restaurant.save
	user.first.voted = true
	user.first.remember = cookies[:remember]
	user.first.save
      end
      redirect_to root_path
  end
  
  def reset
    if params[:pass] == "vonviska"
       User.update_all(:voted => false)
       User.update_all("food = ''")
       Restaurant.update_all("votes = 0")
    elsif params[:pass] == "vonusers"
       User.update_all(:voted => false)
    elsif params[:pass] == "vonrestaurants"
       Restaurant.update_all("votes = 0")
    end
    redirect_to root_path
  end
  
  def start
     # if params[:pass] == "vonviska"
	
	
  end
end
