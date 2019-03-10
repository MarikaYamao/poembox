class PoemsController < ApplicationController
  before_action :require_user_logged_in,only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_poem, only: [:show, :edit, :update, :destroy]

  
  def new
    @poem = Poem.new
    @photo = Photo.find_by(id: params[:format])
  end
  
  def show
    @photo = Photo.find_by(id: @poem.photo_id)
  end
  
  def create
    @poem = current_user.poems.build(poem_params)
    @photo = Photo.find_by(id: @poem.photo_id)
    if @poem.save
      flash[:success] = 'Poemを投稿しました。'
      redirect_to @poem
    else
      flash.now[:danger] = 'Poemの投稿に失敗しました。'
      render new_poem_path
    end
  end
    
  def edit
    @photo = Photo.find_by(id: @poem.photo_id)
  end
  
  def update
    if @poem.update(poem_params)
      flash[:success] = 'Poemを更新しました。'
      redirect_to @poem
    else
      flash.now[:danger] = 'Poemの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    if @poem.destroy
      flash[:success] = 'Poemを削除しました。'
      redirect_to root_url
    else
      flash[:danger] = "Poemの削除に失敗しました。"
      render @poem
    end
  end
  
  private
  def set_poem
    @poem = Poem.find(params[:id])
  end
  
  def poem_params
    params.require(:poem).permit(:content,:photo_id)
  end
  
  def correct_user
    @poem = current_user.photos.find_by(id: params[:id])
    unless @poem
      redirect_to root_url
    end
  end
end
