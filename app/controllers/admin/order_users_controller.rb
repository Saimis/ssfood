module Admin
  class OrderUsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_order_user, only: [:destroy]

    def destroy
      @order_user.destroy
      redirect_to :back
    end

    private

    def set_order_user
      @order_user = OrderUser.find(params[:id])
    end
  end
end
