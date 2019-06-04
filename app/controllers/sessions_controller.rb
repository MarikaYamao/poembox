class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].downcase
    password = params[:password]
    if login(email, password)
      flash[:success] = 'Login succeeded.'
      redirect_back_or controller: 'users', action: 'show', id: @user.id, user_name: @user.name
    else
      flash.now[:danger] = 'Failed to login.'
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = 'Logged out.'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      log_in(@user)
      return true
    else
      return false
    end
  end
end
