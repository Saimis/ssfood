module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def index
      @last_order = Order.last
      @order_users = last_order_users
    end

    def session_start
      Admin::SessionStart.new
      redirect_to :back
    end

    private

    def last_order_users
      return [] if @last_order.blank?

      OrderUser.where(order_id: @last_order.id).order(:user_id)
    end
  end
end
