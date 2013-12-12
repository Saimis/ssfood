module RestaurantsHelper
  def current_time 
    @current_time = Time.now.hour < 1
  end
  
  def current_round 
  	@current_round = Archyves.last
  end 
end
