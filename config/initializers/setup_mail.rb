#ActionMailer::Base.smtp_settings = {
#  :address              => "smtp.mail.microsoftonline.com",
#  :port                 => 587,
#  :domain               => "inteprosfed.com",
#  :user_name            => "shoge",
#  :password             => "K33p0ut!@#",
#  :authentication       => "plain",
#  :enable_starttls_auto => true
#}

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "scott.hoge",
  :password             => "K33p0ut!",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

if Rails.env.development?
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
  Mail.register_interceptor(DevelopmentMailInterceptor)
else
  ActionMailer::Base.default_url_options[:host] = "contrack.inteprosfed.com"
end