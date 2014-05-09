class MainController < ApplicationController

  def index
    @restaurants = Restaurant.order("name").all
    @users = User.where("name != 'admin'").order('name').all
    current_round = Archyves.last
    
    if current_round
      time = current_round.date
      @restaurant_time = time.asctime.to_s
      @food_time = (time + current_round.food_time).asctime.to_s
    end
  end

  #the main information source for long poller, returns all information about users and restaurants
  def get_data
    users_without_admin = User.where("name != 'admin'").count
    current_round = Archyves.last
    users = Userarchyves.select('user_id, food, voted_for').where(archyves_id: current_round.id).all
    retaurants = Restaurant.select('id, votes').all
    vote_check = Restaurant.where("votes > 0")
    winner = {}
    food_history = {}
    round_end = false

    #if there's no winner set yet and all users voted or time ended and also if any restaurant got a vote
    if current_round.restaurant_id.nil? and (voted_users >= users_without_admin or Time.now > current_round.date.to_datetime)
      winner = Restaurant.order("votes DESC, RANDOM()").first
      current_round.restaurant_id = winner.id
      current_round.save
    elsif current_round.restaurant_id
      winner = Restaurant.find(current_round.restaurant_id)
    end

    if current_round.restaurant_id and current_user
       food_history = Userarchyves.joins(:archyves)
        .where("userarchyves.user_id = ?",current_user.id)
        .where("archyves.restaurant_id = ?", current_round.restaurant_id)
        .order("userarchyves.id DESC")
    end

    if Time.now > (current_round.date + current_round.food_time)
      round_end = true
    end
    
    # return json 
    respond_to do |format|
      format.json {
       render json: {
         users: users.as_json(only: [:user_id, :food, :voted]),
         restaurants: retaurants.as_json(only: [:id, :votes]),
         winner: winner.as_json(only: [:id]),
         food_history: food_history.as_json(only: [:food]),
         round_end: round_end.as_json
        }
      }
    end
  end
  
  def destroy_userarchyve
    if current_user and current_user.name == 'admin'
      Userarchyves.destroy(params[:id])
      redirect_to admin_url
    else 
      redirect_to root_path
    end
  end
end
