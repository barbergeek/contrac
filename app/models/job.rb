# == Schema Information
# Schema version: 20110307214329
#
# Table name: jobs
#
#  id         :integer         not null, primary key
#  jobtype    :string(255)
#  data       :binary
#  created_at :datetime
#  updated_at :datetime
#

class Job < ActiveRecord::Base
  
  attr_accessible :jobtype, :data
  
  JOB_TYPES = %w(input)
end
