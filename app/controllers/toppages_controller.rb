class ToppagesController < ApplicationController
  def index
      @photos = Photo.all
      @poems = Poem.all
  end
end
