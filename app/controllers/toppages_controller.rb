class ToppagesController < ApplicationController
  def index
      @photos = Photo.all
      @poems = Poem.all
      logged_in?
  end
end
