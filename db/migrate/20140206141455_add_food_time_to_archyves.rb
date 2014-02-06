class AddFoodTimeToArchyves < ActiveRecord::Migration
  def change
  	add_column :archyves, :food_time, :integer
  end
end
