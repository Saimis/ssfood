class UsersController < ApplicationController
  def change_password
    @user = current_user
  end

  #save food from user input via ajax post
  def save_food
    if current_user && can_save?
      user = current_user
      if current_user
        order_user = current_order_user(user.id)
        user.food = order_user.food = strip_tags(params[:food])
        user.sum = order_user.sum = strip_tags(params[:sum])
        user.save
        order_user.save
      end
    end
    redirect_to root_path
  end

  def save_sun
    if current_user && can_save?
      user = current_user
      if current_user
        order_user = current_order_user(user.id)
        user.sum = order_user.sum = strip_tags(params[:sum])
        user.save
        order_user.save
      end
    end
    redirect_to root_path
  end

  private

  def last_order
    @last_order ||= Order.last
  end

  def can_save?
    last_order.complete? == false
  end

  def current_order_user(uid)
    OrderUser.where(user_id: uid, order_id: last_order.id).first
  end

  def strip_tags(param)
    ActionController::Base.helpers.strip_tags(param)
  end
end
