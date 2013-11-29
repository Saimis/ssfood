module RestaurantsHelper
  def current_time 
    @current_time = Time.now.hour < 1
  end
  
 
end
