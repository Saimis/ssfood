class AddFoodDatetime < ActiveRecord::Migration
  def change
  	add_column :archyves, :food_datetime, :datetime
  end
end
