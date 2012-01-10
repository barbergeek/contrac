require 'mechanize'

class GovwinIQ

  IQ_HOST = "http://iq.govwin.com"

  def self.scrape_all_news
    login
    Opportunity.with_input_records.each do |o|
      puts "Scraping #{o.input_opportunity_number} - #{o.program}"
      $stdout.flush
      scrape_news(o.input_opportunity_number)
    end
  end

  def self.get_export
    login
    #http://iq.govwin.com/index.cfm?fractal=opportunities.dsp.mypreferences.mycompanyopps.exportfieldpref
      #&prdctCd=PXSMI&returnFractal=myInput.dsp.myCompanyOpportunities
      #&exportFractal=myinput.act.downloadmymarkedopportunitiestoexcel
    @agent.get("#{IQ_HOST}/index.cfm?fractal=opportunities.dsp.mypreferences.mycompanyopps.exportfieldpref&prdctCd=PXSMI&returnFractal=myInput.dsp.myCompanyOpportunities&exportFractal=myinput.act.downloadmymarkedopportunitiestoexcel")
    form = @agent.page.form("SelectListForm")
#    form.button_with(text: ">>").click
    form.submit
    f = File.new("tmp/govwin-iq-export.xls","w")
    f.write(@agent.page.body)
    f.close
  end

  def self.scrape_news(inputid)
    login
    @agent.get("#{IQ_HOST}/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
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
    @agent.get("#{IQ_HOST}/getopp.cfm?OppID=#{inputid}&PrdctCd=PFOIT&ClickThruType=Up&archive")
    oppname = @agent.page.search(".detailName").map(&:text).map(&:strip)
    oppdata = @agent.page.search(".detailSectionOuterBorder span").map(&:text).map(&:strip).map! {|item| item.gsub(/\u{a0}/,"").squish }
    puts "Scraping [#{inputid}] - #{oppname[0]}"
    return oppname[0].gsub(/\u{a0}/,"").squish, oppdata
  end

  def self.get_company_opportunities

    #
    # THIS PROCEDURE IS BROKEN
    #

    data_columns = {
      "Department:" => :department,
      "Agency:" => :agency,
      "Solicitation #:" => :rfp_number,
      "Value($K):" => :program_value,
      "Solicitation Release Date:" => :rfp_date,
      "Status:" => :status,
      "Award Date:" => :project_award_date,
      "Contract Type:" => :contract_type_combined,
      "Primary Requirement:" => :primary_service,
      "Contract Duration" => :contract_duration,
      "Updated :" => :last_updated,
      "Competition Type:" => :competition_type,
      "Primary NAICS Code:" => :naics,
      "Place of Performance:" => :primary_state_of_performance,
    }

    login
    @agent.get("#{IQ_HOST}/index.cfm?fractal=myInput.dsp.myCompanyOpportunities&showall")
    #table = @agent.page.search(".resultsTableBorder")
    opportunity_ids = @agent.page.search(".resultsDataTxt:nth-child(4)").map(&:text).map(&:strip).map(&:chop)
    opportunity_ids.each do |inputid|
      input = InputRecord.find_or_create_by_input_opportunity_number(inputid)
      oppname, oppdata = GovwinIQ.scrape_opportunity(inputid)

      # extract title and acronym
      x = /(.*)\s\((.*)\)|(.*)/.match(oppname)    # title (acronym) | title | title (acronym1)(acronym2)
      puts "#{inputid} - #{x[0]}||#{x[1]}||#{x[2]}"
      input.title = x[1] || x[0]
      input.acronym = x[2]


      input.organization = (oppdata[2] + "/" + oppdata[4])
      #oppdata[6] => office
      input.status = oppdata[8]
      input.rfp_date = oppdata[10]
      input.project_award_date = oppdata[12]
      input.rfp_number = oppdata[14]
      input.program_value = oppdata[16]
      input.competition_type = oppdata[18]
      input.primary_service = oppdata[20] #=> primary requirement
      input.contract_duration = oppdata[22]
      input.contract_type = oppdata[24]
      #oppdata[26] => number of awards anticipated
      input.naics = oppdata[28]
      input.primary_state_of_performance = oppdata[30]
      #oppdata[32] => opportunity website (need to find link)
      input.last_updated = oppdata[32]

      input.save
    end
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
