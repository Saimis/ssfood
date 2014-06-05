class UsersController < ApplicationController
  before_action :admin_check, only: [:index, :show, :edit,  :destroy, :new, :create]
  before_action :set_user, only:  [:show, :edit, :update, :destroy]

  def admin_check 
    if self.current_user.nil? or self.current_user.name != 'admin'
      redirect_to root_path
    end
  end

  # GET /users`
  # GET /users.json
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
        food = ActionController::Base.helpers.strip_tags(params[:food])
        userarchyve = Userarchyves.where(user_id: user.id, archyves_id: current_round.id).first
        user.food = userarchyve.food = food 
        user.save
        userarchyve.save
      end
    end
    redirect_to root_path
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
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
      if self.current_user and self.current_user.name == 'admin'
        @user = User.find(params[:id])
      else
        @user = User.find(current_user.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :ip, :voted, :food, :decided, :password, :remember, :password_confirmation)
    end

    def voted_users
      @voted_users = Userarchyves.where("voted_for > 0 AND archyves_id = ?", current_round.id).count
    end

    def current_round
      Archyves.last
    end

    def can_save?
      (Time.now > current_round.date.to_datetime || voted_users >= users_without_admin) and (Time.now < current_round.food_datetime.to_datetime)
    end

    def users_without_admin
      User.all.count - 1
    end
end
