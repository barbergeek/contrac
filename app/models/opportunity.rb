# == Schema Information
# Schema version: 20110202191731
#
# Table name: opportunities
#
#  id                    :integer         not null, primary key
#  acronym               :string(255)
#  program               :string(255)
#  department            :string(255)
#  agency                :string(255)
#  description           :text
#  location              :string(255)
#  input_number          :integer
#  total_value           :integer
#  win_probability       :integer
#  contract_length       :string(255)
#  solicitation_type     :string(255)
#  contract_type         :string(255)
#  rfp_release_date      :date
#  rfp_due_date          :date
#  award_date            :date
#  prime                 :string(255)
#  capture_phase         :string(255)
#  business_developer_id :integer
#  comments              :text
#  created_at            :datetime
#  updated_at            :datetime
#

class Opportunity < ActiveRecord::Base
  attr_accessible :acronym, :program, :department, :agency, :description, :location,
                  :input_number, :total_value, :win_probability, :contract_length, :solicitation_type,
                  :contract_type, :rfp_release_date, :rfp_due_date, :award_date, :prime, :capture_phase
                  
  validates :acronym, :presence => true
  validates :department, :presence => true
  validates :agency, :presence => true
  
end
