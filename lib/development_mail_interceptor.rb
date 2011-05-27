class DevelopmentMailInterceptor
  
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "scott.hoge@gmail.com"
  end

end