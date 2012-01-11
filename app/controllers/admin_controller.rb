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
    GovwinIQ.delay.scrape_all_news
    flash[:notify] = "GovWin IQ news scraper queued"
    redirect_to root_path
  end

  def get_export
    GovwinIQ.delay.export_and_load
    flash[:notify] = "GovWin IQ export and load queued"
    redirect_to root_path
  end

end
