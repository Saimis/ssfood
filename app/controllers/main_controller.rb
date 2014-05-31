class MainController < ApplicationController

  def index
    @restaurants = Restaurant.order("name").all
    @users = User.where("name != 'admin'").order('name').all
    
    if current_round
      @restaurant_time = current_round.date.asctime.to_s
      @food_time = current_round.food_time.asctime.to_s
    end
  end

  #the main information source for long poller, returns all information about users and restaurants
  def get_data
    users_without_admin = User.where("name != 'admin'").count
    users = Userarchyves.select('user_id, food, voted_for').where(archyves_id: current_round.id).all
    retaurants = Restaurant.select('id, votes').all
    winner = {}
    food_history = {}
    round_end = false

    #if there's no winner set yet and all users voted or time ended and also if any restaurant got a vote
    if winner?
      winner = Restaurant.order("votes DESC, RANDOM()").first
      save_winner(winner.id)
    elsif current_round.restaurant_id
      winner = Restaurant.find(current_round.restaurant_id)
    end

    if current_round.restaurant_id and current_user
       food_history = Userarchyves.joins(:archyves)
        .where("userarchyves.user_id = ?", current_user.id)
        .where("archyves.restaurant_id = ?", current_round.restaurant_id)
        .order("userarchyves.id DESC")
    end

    if Time.now > current_round.food_time
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

  def winner?
    users_without_admin = User.where("name != 'admin'").count
    current_round.restaurant_id.nil? and 
      (voted_users >= users_without_admin or Time.now > current_round.date.to_datetime)
  end
  
  def destroy_userarchyve
    if current_user and current_user.name == 'admin'
      Userarchyves.destroy(params[:id])
      redirect_to admin_url
    else 
      redirect_to root_path
    end
  end

  def voted_users
    @voted_users = Userarchyves.where("voted_for > 0 AND archyves_id = ?", current_round.id).count
  end

  def current_round
    Archyves.last
  end

  def save_winner(restaurant_id)
    round = current_round
    round.restaurant_id = restaurant_id
    round.save
  end
end
