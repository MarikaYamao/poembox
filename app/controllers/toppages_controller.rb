class ToppagesController < ApplicationController
  def index
    if logged_in?
      @photos = current_user.feed_photos.page(params[:page])
      @poems = current_user.feed_poems.page(params[:page])
    else
      @photos = Photo.all.page(params[:page])
      @poems = Poem.all.page(params[:page])
    end
  end
  
  def index_all
    @photos = Photo.all.page(params[:page])
    @poems = Poem.all.page(params[:page])
  end
end
