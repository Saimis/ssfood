class StatisticsController < ApplicationController
  def index
    @data = Statistics::Data.new(current_user).data
  end
end
