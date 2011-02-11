class ApplicationController < ActionController::Base
  protect_from_forgery
  include ActionView::Helpers::TextHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
end
