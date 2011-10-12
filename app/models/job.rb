class Job < ActiveRecord::Base
  
  attr_accessible :jobtype, :data
  
  JOB_TYPES = %w(input)
end

# == Schema Information
#
# Table name: jobs
#
#  id         :integer         primary key
#  jobtype    :string(255)
#  data       :binary
#  created_at :timestamp
#  updated_at :timestamp
#

