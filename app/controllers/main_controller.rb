class MainController < ApplicationController

  def index
    @restaurants = Restaurant.all.order("name ASC")
    @users = User.find(:all, :conditions => ["name != 'admin'"], :order => ["name ASC"])
    current_round = Archyves.last
    
    if !current_round.nil?
      time = current_round.date
      @restaurant_time = time.asctime.to_s
      @food_time = (time + current_round.food_time).asctime.to_s
    end
  end

  #the main information source for long poller, returns all information about users and restaurants
  def getData
    users_without_admin = User.all.count - 1
    current_round = Archyves.last
    users = Userarchyves.all(:select => 'user_id, food, voted_for', :conditions => 'archyves_id = ' + current_round.id.to_s)
    retaurants = Restaurant.all(:select => 'id, votes')
    vote_check = Restaurant.where("votes > 0")
    winner = {}
    food_history = {}

    #if there's no winner set yet and all users voted or time ended and also if any restaurant got a vote
    if current_round.restaurant_id.nil? && (voted_users >= users_without_admin || Time.now > current_round.date.to_datetime) && vote_check.count > 0 
      winner = Restaurant.order("votes DESC, RANDOM()").first
      current_round.restaurant_id = winner.id
      current_round.save
    elsif !current_round.restaurant_id.nil?
      winner = Restaurant.find(current_round.restaurant_id)
    end

    if !current_round.restaurant_id.nil? && !current_user.nil?
       food_history = Userarchyves.joins(:archyves)
        .where("userarchyves.user_id = ?",current_user.id.to_s)
        .where("archyves.restaurant_id = ?", current_round.restaurant_id.to_s)
        .order("userarchyves.id DESC")
    end
    
    # return json 
    respond_to do |format|
      format.json {
       render :json => {
         :users => users.as_json(:only => [:user_id, :food, :voted]),
         :restaurants => retaurants.as_json(:only => [:id, :votes]),
         :winner => winner.as_json(:only => [:id]),
         :food_history => food_history.as_json(:only => [:food]),
        } 
      }
    end
  end
  
  def destroy_userarchyve
    if current_user.nil? || current_user.name != 'admin'
      redirect_to root_path
    else 
      Userarchyves.destroy(params[:id])
      redirect_to admin_url
    end
  end
end