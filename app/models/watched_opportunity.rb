class WatchedOpportunity < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
  
end
