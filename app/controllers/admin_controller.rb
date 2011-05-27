class AdminController < ApplicationController
  
  def index
  end
  
  def notify
    User.all.each do |u|
      UserMailer.updated_opportunities(u).deliver
    end
    flash[:notify] = "Notifications Delivered"
    redirect_to root_path
  end

end
