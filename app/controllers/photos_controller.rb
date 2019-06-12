class PhotosController < ApplicationController
  before_action :require_user_logged_in,only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :set_photo, only: [:show, :destroy]
  
  def show
    @photos = Photo.find_by(id: params[:user_id])
    @poems = Poem.where(photo_id: params[:id]).page(params[:page])
  end
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = 'The photo has been posted.'
      redirect_to @photo
    else
      if @photo.errors.any?
        @photo.errors.full_messages.each do |msg|
          flash.now[:danger] = msg
        end
      else
        flash.now[:danger] = 'Failed to post a photo.'
      end
      render :new
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = 'The photo has been deleted.'
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