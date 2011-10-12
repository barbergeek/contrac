class Company < ActiveRecord::Base
  acts_as_taggable_on :certifications
  
end

# == Schema Information
#
# Table name: companies
#
#  id           :integer         primary key
#  name         :string(255)
#  active       :boolean
#  created_at   :timestamp
#  updated_at   :timestamp
#  abbreviation :string(255)
#

