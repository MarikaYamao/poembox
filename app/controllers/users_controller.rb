class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :follow, :like]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
  end
  
  def show
    @photos = @user.photos.order('created_at DESC').page(params[:page])
    @poems = @user.poems.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to controller: 'users', action: 'show', id: @user.id, user_name: @user.name, locale: @user.locale
    else
      flash.now[:danger] = t('.failed')
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
      flash[:success] = t('.success')
      redirect_to controller: 'users', action: 'show', id: @user.id, user_name: @user.name
    else
      flash.now[:danger] = t('.failed')
      render :new
    end
  end
  
  def follow
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
    render 'show_follow'
  end
  
  def like
    @photos = @user.favorites_photo.page(params[:page])
    @poems = @user.favorites_poem.page(params[:page])
    render 'show_like'
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t('.failed')
      redirect_to login_url
    end
  end

  def correct_user
    unless current_user?(@user)
      flash[:danger] = t('.failed')
      redirect_to(root_url)
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :note, :time_zone, :locale)
  end
end
