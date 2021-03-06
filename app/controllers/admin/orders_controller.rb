module Admin
  class OrdersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
      @orders = Order.order(id: :desc)
    end

    def show
    end

    def new
      @order = Order.new
    end

    def edit
    end

    def create
      @order = Order.new(order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to admin_order_url(@order), notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to admin_order_url(@order), notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to admin_orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :date, :restaurant_id, :caller_id, :payer_id, :garbage_collector_id)
    end
  end
end
