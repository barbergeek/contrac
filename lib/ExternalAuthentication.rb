require 'net/pop'

module ExternalAuthentication

  def self.pop_login(user,password)
    begin
      Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
      Net::POP3.auth_only('EXCH021.serverdata.net',Net::POP3.default_pop3s_port,user,password)
      return true
    rescue Net::POPAuthenticationError
      return false
    end
  end

end

