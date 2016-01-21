class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :edit,  :destroy, :new, :create]
  before_action :set_user, only:  [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def change_password
    @user = current_user
  end

  #save food from user input via ajax post
  def save_food
    if current_user and can_save?
      user = self.current_user
      if self.current_user
        userarchyve = current_userarchyve(user.id)
        user.food = userarchyve.food = strip_tags(params[:food])
        user.sum = userarchyve.sum = strip_tags(params[:sum])
        user.save
        userarchyve.save
      end
    end
    redirect_to root_path
  end

  def save_sun
    if current_user and can_save?
      user = self.current_user
      if self.current_user
        userarchyve = current_userarchyve(user.id)
        user.sum = userarchyve.sum = strip_tags(params[:sum])
        user.save
        userarchyve.save
      end
    end
    redirect_to root_path
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_url}
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if current_user && current_user.admin?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(
      :name, :lastname, :ip, :voted, :food, :decided, :password, :remember,
      :password_confirmation, :disabled)
  end

  def voted_users
    @voted_users = Userarchyves.where('voted_for > 0')
      .where(archyves_id: current_round.id)
      .count
  end

  def current_round
    Archyves.last
  end

  def can_save?
    current_round.complete? == false
  end

  def users_without_admin
    User.all.count - 1
  end

  def current_userarchyve(uid)
    Userarchyves.where(user_id: uid, archyves_id: current_round.id).first
  end

  def strip_tags(param)
    ActionController::Base.helpers.strip_tags(param)
  end
end
