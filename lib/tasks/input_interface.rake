namespace :input do
  desc "Scrape and update news items from INPUT"
  task :update_news => :environment do
    INPUT.scrape_all_news
  end

  desc "Get Company Opportunities"
  task :get_company_opportunities => :environment do
    INPUT.get_company_opportunities
  end

end
