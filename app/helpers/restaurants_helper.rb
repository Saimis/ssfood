module RestaurantsHelper
	def current_winner(winner_id)
	  Restaurant.find(winner_id)
	end
end
