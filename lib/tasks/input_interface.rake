namespace :govwin do
  desc "Scrape and update news items from Govwin IQ"
  task :update_news => :environment do
    GovwinIQ.scrape_all_news
  end

  desc "Get Company Opportunities"
  task :get_company_opportunities => :environment do
    GovwinIQ.get_company_opportunities
  end

end
