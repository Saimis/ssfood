class ArchyvesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_archive, only: [:show, :edit, :update, :destroy]

  # GET /users`
  # GET /users.json
  def index
    @archyves = Archyves.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @archyve = Archyves.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @archyve = Archyve.new(archyve_params)

    respond_to do |format|
      if @archyve.save
        format.html { redirect_to admin_url }
        format.json { render action: 'show', status: :created, location: @archyve }
      else
        format.html { render action: 'new' }
        format.json { render json: @archyve.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @archyve.update(archyve_params)
        format.html { redirect_to admin_url }
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
    @archyve.destroy
    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  private

  def set_archive
    @archyve = Archyves.find(params[:id])
  end

  def archyve_params
    params.require(:archyves).permit(
      :date, :restaurant_id, :caller, :food_datetime)
  end
end
