class ApplicationController < ActionController::Base
  protect_from_forgery
  include ActionView::Helpers::TextHelper
  include ApplicationHelper
  
  require 'ImportJob'
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def user_signed_in?
    current_user
  end
  helper_method :user_signed_in?
  
end
