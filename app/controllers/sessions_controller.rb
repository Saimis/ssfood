class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user.try(:authenticate, params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def autologin
    params[:session] = {}
    params[:session][:name] = params[:a]
    params[:session][:password] = params[:b]
    create
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
