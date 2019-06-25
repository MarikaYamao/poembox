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
      flash[:success] = t('.success')
      redirect_to @poem
    else
      flash.now[:danger] = t('.failed')
      render new_poem_path
    end
  end
    
  def edit
    @photo = Photo.find_by(id: @poem.photo_id)
  end
  
  def update
    if @poem.update(poem_params)
      flash[:success] = t('.success')
      redirect_to @poem
    else
      flash.now[:danger] = t('.failed')
      render :edit
    end
  end

  def destroy
    if @poem.destroy
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash[:danger] = t('.failed')
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
      flash[:danger] = t('.failed')
      redirect_to root_url
    end
  end
end
