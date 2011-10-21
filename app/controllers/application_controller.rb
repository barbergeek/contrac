class ApplicationController < ActionController::Base
  protect_from_forgery
  include ActionView::Helpers::TextHelper
#  include ApplicationHelper
  
  require 'ImportJob'
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  private

end
