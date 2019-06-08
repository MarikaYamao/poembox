class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
  end
  
  def show
    @photos = @user.photos.order('created_at DESC')
    @poems = @user.poems.order('created_at DESC')
    counts(@user)
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'Has been updated.'
      redirect_to controller: 'users', action: 'show', id: @user.id, user_name: @user.name
    else
      flash.now[:danger] = 'Update failed.'
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      flash[:success] = 'User registration successful.'
      redirect_to controller: 'users', action: 'show', id: @user.id, user_name: @user.name
    else
      flash.now[:danger] = 'Failed to register user.'
      render :new
    end
  end
  
  def follow
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    unless current_user?(@user)
      flash[:danger] = "Can not get the specified url."
      redirect_to(root_url)
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :note)
  end
end
