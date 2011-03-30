namespace :input do
  desc "Scrape and update news items from INPUT"
  task :update_news => :environment do
    INPUT.scrape_all_news
  end
end
