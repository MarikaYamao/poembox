class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_user, only: [:create, :destroy]

  def create
    current_user.follow(@user)
    #redirect_back(fallback_location: root_path)
    respond_to do |format|
     format.html { redirect_to @user }
     format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    #redirect_back(fallback_location: root_path)
    respond_to do |format|
     format.html { redirect_to @user }
     format.js
    end
  end
  
  private
  def set_user
    @user = User.find(params[:follow_id])
  end
end
