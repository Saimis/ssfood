class RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  #get call to vote for restaurant, if user logged in, time is not over and not all users voted
  def vote
    if can_vote?
      user = User.where(remember: cookies[:remember]).first
      if user
        restaurant = Restaurant.find(params[:id])
        userarchyve = Userarchyves.where(user_id: user.id, archyves_id: current_round.id).first_or_create

        if userarchyve.voted_for.nil? and params[:act].nil?
          restaurant.increment(:votes, by = 1)
          userarchyve.voted_for = params[:id]
        elsif userarchyve.voted_for and params[:act].present?
          restaurant.decrement(:votes, by = 1)
           userarchyve.voted_for = nil
        end
        restaurant.save
        userarchyve.save
      end
    end
    redirect_to root_path
  end

  #get back your vote
  def unvote

  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :about, :votes, :waslast, :lastused, :phone, :winner)
    end

    def voted_users
      @voted_users = Userarchyves.where("voted_for > 0 AND archyves_id = ?", current_round.id).count
    end

    def current_round
      Archyves.last
    end

    def can_vote?
      users_without_admin = User.all.count - 1

      current_user and
      Time.now < current_round.date.to_datetime and
      voted_users <= users_without_admin and
      params[:id].present?
    end
end
