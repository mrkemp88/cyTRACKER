class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,	 :only => :destroy
	
	def index
		@title = "All Users"
		@users = User.paginate(:page => params[:page])
	end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @sidebar = "Navigation stuff goes here..."
  end
  
  def new
  	@user = User.new
    @title = "New User"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	sign_in @user
    	flash[:success] = "User created successfully."
      redirect_to @user
    else
      @title = "New User"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def edit
  	@user = User.find(params[:id])
  	@title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User settings updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    @user= User.find(params[:id])
    if current_user?(@user)
    	flash[:notice] = "You cannot delete yourself"
    	redirect_to users_path
   	else
   		@user.destroy
   		flash[:success] = "User destroyed"
   		redirect_to users_path
    end
  end
  
  private
  	
  	def authenticate
  		deny_access unless signed_in?
  	end
  	
  	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
