class RestaurantsController < ApplicationController
  before_action :admin_check, only: [:index, :show, :edit,  :destroy, :new, :create]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def admin_check 
    if !current_user.nil? && current_user.name != 'admin'
      redirect_to root_path
    end
  end

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  #get call to vote for restaurant, if user logged in, time is not over and not all users voted
  def vote
    if current_user && Time.now < current_round.date.to_datetime && voted_users <= 11 && !params[:id].nil?
      user = User.where(:remember => cookies[:remember]).first
      if !user.nil? 
        restaurant = Restaurant.find(params[:id])
        userarchyve = Userarchyves.where(:user_id => user.id, :archyves_id => current_round.id).first_or_create
        #if user.voted.nil? && params[:act].nil?
        if userarchyve.voted_for.nil? && params[:act].nil?
          restaurant.increment(:votes, by = 1)
          #user.voted = params[:id]
          userarchyve.voted_for = params[:id]
        #elsif !user.voted.nil? && !params[:act].nil?
        elsif !userarchyve.voted_for.nil? && !params[:act].nil?
          restaurant.decrement(:votes, by = 1)
          #user.voted = nil
           userarchyve.voted_for = nil
        end
        restaurant.save
        #user.save
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
end
