class LikeController < ApplicationController
  before_action :require_user_logged_in,only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    @Like = current_user.likes.find_or_create_by(like_params)
    flash[:success] = 'いいねしました。'
  end

  def destroy
    @like.destroy
    flash[:success] = 'いいね解除しました。'
  end
  
  private
  def set_like
    @like = Like.find(params[:id])
  end
  
  def like_params
    params.require(:like).permit(:type, :follow, :photo, :poem)
  end
  
  def correct_user
    @like = current_user.likes.find_by(id: params[:id])
    unless @like
      redirect_to root_url
    end
  end
end
