class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Log in user and redirect to user's show page
    else
      # Rerender login form with error message
      flash.now[:danger] = "Invalid login credentials"
      render 'new'
    end
  end

  def destroy
  end
end
