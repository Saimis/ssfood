class OrderUser < ActiveRecord::Base
  scope :with_restaurant, -> { where('restaurant_id > 0') }

  belongs_to :restaurant
  belongs_to :order
  belongs_to :user
end
