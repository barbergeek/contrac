require 'mechanize'

module INPUT

  def self.scrape_all_news
    login
    Opportunity.with_input_records.each do |o|
      puts "Scraping #{o.input_opportunity_number}"
      $stdout.flush
      scrape_news(o.input_opportunity_number)
    end
  end
  
  def self.scrape_news(inputid)
    login
    @agent.get("http://www.input.com/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
    news = @agent.page.search("#oppProcurementActivityContent .detailDataTxt").map(&:text).map(&:strip)
    if news
      opp = Opportunity.find_by_input_opportunity_number(inputid)
      if opp
        news.each do |newsitem|
          if /(?<news_date>[0-1][0-9]\/[0-3][0-9]\/[1-2][0-9][0-9][0-9]) - (?<news_story>.*)/ =~ newsitem
            opp.new_input_comment_with_date(news_story,fix_date(news_date))
          end
        end
      end
    end
  end
  
  def self.login
    unless @agent
      @agent = Mechanize::new
      @agent.get("http://www.input.com/login/loginPage.cfm")
      form = @agent.page.forms.first
      form.username = "shoge@inteprosfed.com"
      form.password="K33p0ut!"
      form.submit
    end
  end
  
  def self.fix_date(datevalue)
    if datevalue =~ /\//
       m,d,y = datevalue.split("/")
       "#{y}-#{m}-#{d}"
     else
       datevalue
     end
  end
  
end