class TimecontrollsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "geraspsw"
  before_action :set_timecontroll, only: [:show, :edit, :update, :destroy]

  # GET /timecontrolls
  # GET /timecontrolls.json
  def index
    @timecontrolls = Timecontroll.all
  end

  # GET /timecontrolls/1
  # GET /timecontrolls/1.json
  def show
  end

  # GET /timecontrolls/new
  def new
    @timecontroll = Timecontroll.new
  end

  # GET /timecontrolls/1/edit
  def edit
  end

  # POST /timecontrolls
  # POST /timecontrolls.json
  def create
    @timecontroll = Timecontroll.new(timecontroll_params)

    respond_to do |format|
      if @timecontroll.save
        format.html { redirect_to @timecontroll, notice: 'Timecontroll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timecontroll }
      else
        format.html { render action: 'new' }
        format.json { render json: @timecontroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timecontrolls/1
  # PATCH/PUT /timecontrolls/1.json
  def update
    respond_to do |format|
      if @timecontroll.update(timecontroll_params)
        format.html { redirect_to @timecontroll, notice: 'Timecontroll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timecontroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timecontrolls/1
  # DELETE /timecontrolls/1.json
  def destroy
    @timecontroll.destroy
    respond_to do |format|
      format.html { redirect_to timecontrolls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timecontroll
      @timecontroll = Timecontroll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timecontroll_params
      params.require(:timecontroll).permit(:start, :end, :gap)
    end
end
