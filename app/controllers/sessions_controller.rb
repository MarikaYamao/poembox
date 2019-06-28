class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].downcase
    password = params[:password]
    if login(email, password)
      if params[:remember_me] == '1'
        @user.remember
      end
      flash[:success] = t('.success')
      redirect_to root_url(locale: @user.locale)
    else
      flash.now[:danger] = t('.failed')
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t('.success')
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      log_in(@user)
      remember(@user)
      return true
    else
      return false
    end
  end
end
