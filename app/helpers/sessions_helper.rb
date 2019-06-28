module SessionsHelper
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.(:remember, cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
      
  end

  def current_user?(user)
    user == current_user
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.signed[:user_id] = { value: user.id,
                               expires: 20.days.from_now }
    cookies[:remember_token] = { value: user.remember_token,
                                      expires: 20.days.from_now }
  end
  
  def forgot(user)
    user.forgot
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !!current_user
  end

  def log_out
    forgot(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
