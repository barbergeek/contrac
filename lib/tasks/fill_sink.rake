namespace :db do
  desc "Fill search sink"
  task :fill_sink => :environment do
    Opportunity.all.each {|opp| 
      opp.fill_search_sink
      opp.save!(false)
      }
  end
end
