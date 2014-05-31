class FoodTimeToDatetime < ActiveRecord::Migration
  def change
  	change_column :archyves, :food_time, :datetime
  end
end
