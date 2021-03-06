class SessionsController < ApplicationController
  def new
  	@title = "Log In"
  end
  
  def create
  	user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid log in infomation"
      @title = "Log In"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
  	sign_out
  	redirect_to login_path
  end

end
