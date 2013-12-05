class MainController < ApplicationController
  
  def index
      @user =User.find_by_remember(cookies[:remember]) #User.where(:remember => cookies[:remember])
      @restaurants = Restaurant.all.order("NAME ASC") #("RANDOM()")
      @ip = request.remote_ip
      @users = User.all.order("NAME ASC")
      @time = Timecontroll.last.timebarrier.asctime.to_s
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
    if current_user && Time.now.asctime < Timecontroll.last.timebarrier.to_datetime && voted_users <= 11
      user = User.where(:remember => cookies[:remember])
      if !user.first.nil? && !user.first.voted
        restaurant = Restaurant.find(params[:id])
	restaurant.increment(:votes, by = 1)
	restaurant.save
	user.first.voted = true
	user.first.save
      end
    end
    redirect_to root_path
  end
  
  def reset
    if params[:pass] == "vonviska"
       
    elsif params[:pass] == "vonusers"
       User.update_all(:voted => false)
    elsif params[:pass] == "vonrestaurants"
       Restaurant.update_all("votes = 0")
    end
    redirect_to root_path
  end
  
  def start
    t = Time.now
    if !t.friday?  && params[:pass] == "vonviska" 
      User.update_all(:voted => false)
      User.update_all(:food => '')
      Restaurant.update_all(:votes => 0)
      
      t += 1200#1800

      Timecontroll.new(:timebarrier => t.asctime).save
      redirect_to root_path
    else 
      redirect_to "http://" + request.env['HTTP_HOST'] + "/not.html"
    end
  end
  
  def getData
    users = User.all(:select => 'id, food, voted')
    retaurants = Restaurant.all(:select => 'id, votes')
    vote_check = Restaurant.where("votes > 0")
    
    winner = {}
  
    if voted_users >= 11 || Time.now.asctime > Timecontroll.last.timebarrier.to_datetime && vote_check.count > 0
      Restaurant.update_all(:waslast => false)
      winner = Restaurant.order("votes DESC").first
      winner.waslast = true
      if !winner.lastused.present? || winner.lastused.to_datetime < Time.now - 24.hours
	winner.lastused = Time.now.to_s
      end
      winner.save
    end 
      
    respond_to do |format|
       format.json { 
	 render :json => {
                       :users => users.as_json(:only => [:id, :food, :voted]),
                       :restaurants => retaurants.as_json(:only => [:id, :votes]),
                       :winner => winner.as_json(:only => [:id, :votes])
                      }
       }
    end
  end
end
