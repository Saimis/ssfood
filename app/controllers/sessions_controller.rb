class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user.try(:authenticate, params[:session][:password])
      sign_in user
      if user.name == 'admin'
        redirect_to admin_url
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
    AdminController.new.start
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
