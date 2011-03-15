# == Schema Information
# Schema version: 20110315145530
#
# Table name: watched_opportunities
#
#  id             :integer         not null, primary key
#  opportunity_id :integer
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class WatchedOpportunity < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
  
end
