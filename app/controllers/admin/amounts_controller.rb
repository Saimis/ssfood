module Admin
  class AmountsController < ApplicationController
    before_action :authenticate_admin!

    def index
      manager = Admin::AmountsManager.new(params).call

      @order = manager[:order]
      @order_users = manager[:order_users]
      @total = manager[:total]
    end
    alias_method :show, :index
  end
end
