class MainController < ApplicationController
  def index
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
    if current_user
      user = User.where(:remember => cookies[:remember]).first
      if !user.nil?
	user.food = ActionController::Base.helpers.strip_tags(params[:food])
	user.save
      end
    end
    redirect_to root_path
  end
  
  def dovote
    if current_user
      user = User.where(:remember => cookies[:remember])
      if !user.first.nil? && user.first.voted != true && Time.now.hour < 2 || voted_users < 11
        restaurant = Restaurant.find(params[:id])
	restaurant.increment(:votes, by = 1)
	restaurant.save
	user.first.voted = true
	user.first.remember = cookies[:remember]
	user.first.save
      end
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
    Time.now.hour
    time = Timecontroll.new('start','','')
	
  end
  
   def getData
    @users = User.all(:select => 'id, food, voted')
    @retaurants = Restaurant.all(:select => 'id, votes')
    
    respond_to do |format|
       format.json { 
	 render :json => {
                       :users => @users.as_json(:only => [:id, :food, :voted]),
                       :restaurants => @retaurants.as_json(:only => [:id, :votes])
                      }
       }
    end
  end
end
