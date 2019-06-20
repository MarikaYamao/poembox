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
      flash[:success] = 'Posted a poem.'
      redirect_to @poem
    else
      flash.now[:danger] = 'Poem failed to post.'
      render new_poem_path
    end
  end
    
  def edit
    @photo = Photo.find_by(id: @poem.photo_id)
  end
  
  def update
    if @poem.update(poem_params)
      flash[:success] = 'Poem has been updated.'
      redirect_to @poem
    else
      flash.now[:danger] = 'Failed to update the poem.'
      render :edit
    end
  end

  def destroy
    if @poem.destroy
      flash[:success] = 'Poem has been deleted.'
      redirect_to root_url
    else
      flash[:danger] = "Failed to delete the poem."
      render @poem
    end
  end
  
  private
  def set_poem
    @poem = Poem.find(params[:id])
  end
  
  def poem_params
    params.require(:poem).permit(:title, :content, :photo_id)
  end
  
  def correct_user
    @poem = current_user.poems.find_by(id: params[:id])
    unless @poem
      flash[:danger] = "Can not get the specified url."
      redirect_to root_url
    end
  end
end
