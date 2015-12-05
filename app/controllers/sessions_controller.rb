class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user.try(:authenticate, params[:session][:password])
      sign_in user

      if user.admin?
        redirect_to admin_dashboard_url
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def autologin
    params[:session] = {}
    params[:session][:name] = params[:a]
    params[:session][:password] = params[:b]

    create

    if current_user && current_user.admin?
      AdminController.new.start
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
