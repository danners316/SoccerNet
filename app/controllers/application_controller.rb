
class ApplicationController < ActionController::Base
    protect_from_forgery

  private

    def create
      user = User.find_by_name(params[:name])
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_url
      else
        redirect_to login_url, alert: "Invalid user/password combination"
      end
    end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  # ...

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  helper_method :is_admin?

  def is_admin?
    if current_user and (current_user.admin == true)
      return true
    else
      access_denied
    end
  end

  def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
  end
    helper_method :current_user

end
