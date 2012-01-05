require 'mechanize'

class INPUT
  
  INPUT_HOST = "http://iq.govwin.com"

  def self.scrape_all_news
    login
    Opportunity.with_input_records.each do |o|
      puts "Scraping #{o.input_opportunity_number} - #{o.program}"
      $stdout.flush
      scrape_news(o.input_opportunity_number)
    end
  end
  
  def self.scrape_news(inputid)
    login
    @agent.get("#{INPUT_HOST}/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
    news = @agent.page.search("#oppProcurementActivityContent .detailDataTxt").map(&:text).map(&:strip)
    if news
      input = InputRecord.find_or_create_by_input_opportunity_number(inputid)
      news.each do |newsitem|
        if /(?<news_date>[0-1][0-9]\/[0-3][0-9]\/[1-2][0-9][0-9][0-9]) - (?<news_story>.*)/ =~ newsitem
          input.new_news_with_date(news_story,fix_input_date(news_date))
        end
      end
    end
  end

  def self.scrape_opportunity(inputid)
    login
    @agent.get("#{INPUT_HOST}/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
    opp = @agent.page.search(".detailSectionOuterBorder span").map(&:text).map(&:strip)
  end
  
  def self.get_company_opportunities
    login
    @agent.get("#{INPUT_HOST}/index.cfm?fractal=myInput.dsp.myCompanyOpportunities&showall")
    #table = @agent.page.search(".resultsTableBorder")
    opportunity_ids = @agent.page.search(".resultsDataTxt:nth-child(4)").map(&:text).map(&:strip).map(&:chop)
  end

  def self.login
    unless @agent
      @agent = Mechanize::new
      @agent.get("https://iq.govwin.com/login/loginPage.cfm")
      form = @agent.page.form_with(id: 'frmLoginForm')
      form.username = Setting.input_username
      form.password = Setting.input_password
      form.submit
    end
  end
  
  def self.find_input(inputid)
    @input = InputRecord.find_or_create_by_input_opportunity_number(inputid)
  end
  
  def self.fix_input_date(datevalue)
    if datevalue =~ /\//
       m,d,y = datevalue.split("/")
       "#{y}-#{m}-#{d}"
     else
       datevalue
     end
  end
  
end
