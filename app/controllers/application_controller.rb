class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include RestaurantsHelper
  include UsersHelper

  def authenticate_admin!
    return if current_user && current_user.admin?
    redirect_to :root
  end

  #rescue_from Exception, :with => :error_render_method

  #def error_render_method
  #  redirect_to "http://" + request.env['HTTP_HOST'] + "/404.html"
  #  true
  #end
end
