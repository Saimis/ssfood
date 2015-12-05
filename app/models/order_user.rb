class OrderUser < ActiveRecord::Base
  scope :with_restaurant, -> { where('restaurant_id > 0') }

  belongs_to :restaurant
  belongs_to :archyves
  belongs_to :user
end
