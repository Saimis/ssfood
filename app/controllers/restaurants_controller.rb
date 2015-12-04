class RestaurantsController < ApplicationController
  before_action :authenticate_admin!, except: [:vote]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def vote
    if can_vote?
      user = User.where(remember: cookies[:remember]).first
      if user
        restaurant = Restaurant.find(params[:id])
        userarchyve = Userarchyves.where(user_id: user.id, archyves_id: current_round.id).first_or_create

        if userarchyve.voted_for.nil? && params[:act].nil?
          restaurant.increment(:votes, 1)
          userarchyve.voted_for = params[:id]
        elsif userarchyve.voted_for && params[:act].present?
          restaurant.decrement(:votes, 1)
          userarchyve.voted_for = nil
        end
        restaurant.save
        userarchyve.save
      end
    end
    redirect_to root_path
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
  end

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

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

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

    current_user &&
      Time.zone.now < current_round.date.to_datetime &&
      voted_users <= users_without_admin &&
      params[:id].present?
  end
end
