class AdminController < ApplicationController
  def index
    @total_orders = Order.count
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user
end
