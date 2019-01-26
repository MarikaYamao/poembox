class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
  end
  
  def show
    @photos = @user.photos.order('created_at DESC')
    @poems = @user.poems.order('created_at DESC')
    @likeList = Array.new
    @likes = Like.all.order('created_at ASC').each do |like|
      case like.type
      when 'Follow' then
        @likeList.push(User.find(like.follow_id))
        puts 'Follow'
      when 'LikePhoto' then
        @likeList.push(Photo.find(like.photo_id))
        puts 'Follow'
      when 'LikePoem' then
        @likeList.push(Poem.find(like.poem_id))
        puts 'Follow'
      end
    end
    puts @likeList.inspect
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = '正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :note)
  end
  
end
