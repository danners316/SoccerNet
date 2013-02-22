
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.order(:title)
    @cart = current_cart
    @products = Product.search(params[:search_query])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
  end
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

end


