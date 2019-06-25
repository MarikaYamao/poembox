class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  around_action :user_time_zone, if: :current_user
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_photos = user.photos.count
    @count_poems = user.poems.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
  
  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= params[:locale] ||= I18n.default_locale
  end

  def default_url_options(options={})
    options.merge(locale: locale)
  end
  
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end
