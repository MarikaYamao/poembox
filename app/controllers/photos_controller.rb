class PhotosController < ApplicationController
  before_action :require_user_logged_in,only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :set_photo, only: [:show, :destroy]
  
  def show
    @photos = Photo.find_by(id: params[:user_id])
    @poems = Poem.where(photo_id: params[:id])
  end
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = '画像を投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '画像の投稿に失敗しました。'
      render new_photo_path
    end
  end

  def destroy
    @poems = Poem.where(photo_id: @photo.id)
    @poems.destroy_all
    @photo.destroy
    flash[:success] = '画像を削除しました。'
    redirect_to root_url
  end
  
  private
  def set_photo
    @photo = Photo.find(params[:id])
  end
  
  def photo_params
    params.require(:photo).permit(:image_name) if params[:photo].present?
  end
  
  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    unless @photo
      redirect_to root_url
    end
  end
end