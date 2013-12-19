class MainController < ApplicationController

  def index
      @restaurants = Restaurant.all.order("NAME ASC") #("RANDOM()")
      @users = User.all.order("NAME ASC")
      if !Archyves.last.nil?
        time = Archyves.last.date
        @restaurant_time = time.asctime.to_s
        @food_time = (time+40).asctime.to_s
      end
   end

  def choosefood
     @user = User.where(:remember => cookies[:remember]).first
     @food = @user.food
  end

  def start
    t = Time.now
    if t.friday?  && params[:pass] == "vonviska"
      #User.update_all(:voted => nil)
      User.update_all(:food => nil)
      Restaurant.update_all(:votes => 0)
      t += 100#00
      archyve = Archyves.create :date => t
      User.all().each do |user|
        Userarchyves.create :user_id => user.id, :archyves_id => archyve.id
      end

      redirect_to root_path
    else
      redirect_to "http://" + request.env['HTTP_HOST'] + "/not.html"
    end
  end

  #the main information source for long poller, returns all information about users and restaurants
  def getData
    #users = User.all(:select => 'id, food, voted')
    users = Userarchyves.all(:select => 'user_id, food, voted_for', :conditions => 'archyves_id = ' + current_round.id.to_s)
    retaurants = Restaurant.all(:select => 'id, votes')
    vote_check = Restaurant.where("votes > 0")
    winner = {}
    
    
    #if there's no winner set yet and all users voted or time ended and also if any restaurant got a vote
    if current_round.restaurant_id.nil? && (voted_users >= 11 || Time.now > Archyves.last.date.to_datetime) && vote_check.count > 0 
      archyve = Archyves.find(current_round.id)
      winner = Restaurant.order("votes DESC, RANDOM()").first
      archyve.restaurant_id = winner.id
      archyve.save
    elsif !current_round.restaurant_id.nil?
      winner = Restaurant.find(current_round.restaurant_id)
    end

    respond_to do |format|
      format.json {
       render :json => {
         :users => users.as_json(:only => [:user_id, :food, :voted]),
         :restaurants => retaurants.as_json(:only => [:id, :votes]),
         :winner => winner.as_json(:only => [:id])
        } 
      }
    end
  end

  def view_archyves
    @rounds = Archyves.all 
    @userarchyves = Userarchyves.find(:all)
  end

  def destroy_archyve
    Archyves.destroy(params[:id])
    redirect_to archyve_path
  end

  def destroy_userarchyve
    Userarchyves.destroy(params[:id])
    redirect_to archyve_path
  end
end