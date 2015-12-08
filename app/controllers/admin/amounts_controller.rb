module Admin
  class AmountsController < ApplicationController
    before_action :authenticate_admin!

    def index
      manager = Admin::AmountsManager.new.call

      @order = manager[:order]
      @order_users = manager[:order_users]
      @total = manager[:total]
    end
  end
end
