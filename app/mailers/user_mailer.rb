class UserMailer < ActionMailer::Base
  default :from => "shoge@inteprosfed.com"
  
  def updated_opportunities(user)
    @user = user
    @opportunities = Opportunity.my_updated(user, user.last_notified_at || 1.week.ago )
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Contrack Updated Opportunities")
    user.last_notified_at = Time.now
    user.save!
  end
  
end
