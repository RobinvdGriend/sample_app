class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Log in user and redirect to user's show page
      log_in(user)
      redirect_to user_path(user)
    else
      # Rerender login form with error message
      flash.now[:danger] = "Invalid login credentials"
      render 'new'
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:notice] = "You're logged out. Thank you for visiting"
      redirect_to root_path
    else
      flash[:dange] = "Can't log out if you're not logged in"
      redirect_to root_path
    end
  end
end
