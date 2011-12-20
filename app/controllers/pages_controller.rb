class PagesController < ApplicationController
  helper PortletsHelper
#  before_filter :store_location
  
  def master
  end
  
  def home
    @announcements = Announcement.for_front_page
  end

  def about
  end

  def help
  end

  def contact
  end

end
