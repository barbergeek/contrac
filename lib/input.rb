require 'mechanize'

module INPUT

  def self.scrape_news(inputid)
    agent = Mechanize::new
    login agent
    agent.get("http://www.input.com/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
    agent.page.search("#oppProcurementActivityContent .detailDataTxt").map(&:text).map(&:strip)
  end
  
  def self.login(agent)
    agent.get("http://www.input.com/login/loginPage.cfm")
    form = agent.page.forms.first
    form.username = "shoge@inteprosfed.com"
    form.password="K33p0ut!"
    form.submit
  end
    
end