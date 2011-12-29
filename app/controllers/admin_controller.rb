class AdminController < ApplicationController
  
  before_filter :require_login
  
  def index
  end
  
  def notify
    User.all.each do |u|
      UserMailer.updated_opportunities(u).deliver
    end
    flash[:notify] = "Notifications Delivered"
    redirect_to root_path
  end

  def scrape_news
    INPUT.delay.scrape_all_news
    flash[:notify] = "GovWin IQ news scraper queued"
    redirect_to root_path
  end

end
