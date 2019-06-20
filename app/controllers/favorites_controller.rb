class FavoritesController < ApplicationController
  def create
    if params[:type] == 'LikePhoto'
      @type = 'LikePhoto'
      @photo = Photo.find(params[:photo_id])
      current_user.like_photo(@photo)
      respond_to do |format|
       format.html { redirect_to @photo }
       format.js
      end
      
    elsif params[:type] == 'LikePoem'
      @type = 'LikePoem'
      @poem = Poem.find(params[:poem_id])
      current_user.like_poem(@poem)
      respond_to do |format|
       format.html { redirect_to @poem }
       format.js
      end
      
    end
  end

  def destroy
    if params[:type] == 'LikePhoto'
      @type = 'LikePhoto'
      @photo = Photo.find(params[:photo_id])
      current_user.unlike_photo(@photo)
      respond_to do |format|
       format.html { redirect_to @photo }
       format.js
      end
      
    elsif params[:type] == 'LikePoem'
      @type = 'LikePoem'
      @poem = Poem.find(params[:poem_id])
      current_user.unlike_poem(@poem)
      respond_to do |format|
       format.html { redirect_to @poem }
       format.js
      end
      
    end
  end
end
