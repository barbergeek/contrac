class PagesController < ApplicationController
  helper PortletsHelper
  before_filter :store_location
  
  def home
  end

  def about
  end

  def help
  end

  def contact
  end

end
