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

end
