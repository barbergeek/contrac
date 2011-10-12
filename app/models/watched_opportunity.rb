class WatchedOpportunity < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
  
end

# == Schema Information
#
# Table name: watched_opportunities
#
#  id             :integer         primary key
#  opportunity_id :integer
#  user_id        :integer
#  created_at     :timestamp
#  updated_at     :timestamp
#

