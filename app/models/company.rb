# == Schema Information
# Schema version: 20110505020629
#
# Table name: companies
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  active       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  abbreviation :string(255)
#

class Company < ActiveRecord::Base
  acts_as_taggable_on :certifications
  
end
