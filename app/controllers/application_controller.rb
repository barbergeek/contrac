class ApplicationController < ActionController::Base
  protect_from_forgery
  include ActionView::Helpers::TextHelper
#  include ApplicationHelper

  require 'ImportJob'

  before_filter :get_upcoming_tasks

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  def get_upcoming_tasks
    if logged_in?
      @upcoming_tasks = Task.my_upcoming(current_user)
    else
      @upcoming_tasks = []
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def require_login
    if !logged_in?
      session[:return_to_url] = request.url if request.get?
      redirect_to login_path
    end
  end
  helper_method :require_login

  def redirect_back_or_to(url, flash_hash = {})
    redirect_to(session[:return_to_url] || url, :flash => flash_hash)
    session[:return_to_url] = nil
  end
  helper_method :redirect_back_or_to

end
