# == Schema Information
# Schema version: 20110224150812
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
#  input_record_id       :integer
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
#  created_at            :datetime
#  updated_at            :datetime
#  input_status          :string(255)
#  acquisition_url       :string(255)
#

class Opportunity < ActiveRecord::Base
  belongs_to :business_developer, :class_name => "User"
  has_many :comments, :as => :commentable
  belongs_to :input_record, :primary_key => "opportunity_id", :readonly => :true
  
  attr_accessible :acronym, :program, :department, :agency, :description, :location,
                  :input_number, :total_value, :win_probability, :contract_length, :solicitation_type,
                  :contract_type, :rfp_release_date, :rfp_due_date, :award_date, :prime, :capture_phase, 
                  :input_status, :business_developer_id, :acquisition_url, :comments, :comments_attributes
                  
  accepts_nested_attributes_for :comments, :reject_if => proc { |attributes| attributes['content'].blank? }
              
#  validates :acronym, :presence => true
  validates :program, :presence => true
  validates :department, :presence => true
#  validates :agency, :presence => true

  def bd_initials
    business_developer.initials
  end
  
end
