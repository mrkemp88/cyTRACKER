class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
  	@user = User.new
    @title = "New User"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	flash[:success] = "User created successfully."
      redirect_to @user
    else
      @title = "New User"
      render 'new'
    end
  end

end
