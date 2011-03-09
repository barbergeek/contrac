# == Schema Information
# Schema version: 20110224191514
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
#  outcome               :string(255)
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
  
  validates :program, :presence => true
  validates :department, :presence => true

  PHASES = %w[identification qualification win_strategy pre-proposal proposal post_submittal post_award]
  OUTCOMES = %w[won lost no_bid]
  
  scope :calendar,
     where("(outcome <> ? or outcome is null) and (capture_phase not in (?) or capture_phase is null) and rfp_release_date is not null and (input_status is null or input_status not in (?))", "no_bid", %w[post_submittal post_award], %w[Post-RFP])
     # where (outcome <> 'no_bid' or outcome is null) and (capture_phase not in ('post_submittal','post_award') or capture_phase is null) and rfp_release_date is not null;

  scope :unawarded,
    where("(outcome not in (?) or outcome is null) and (capture_phase not in (?) or capture_phase is null) and rfp_release_date is not null and (input_status is null or input_status not in (?))", %w[no_bid lost], %w[post_submittal post_award], %w[Post-RFP])
    
  scope :lost,
    where("outcome = 'lost'")
  
  scope :won,
    where("outcome = 'won'")
  
  def self.department_count
    count(:all, :group => "department")
  end
    
  def self.input_status_count
    count(:all, :group => "input_status")
  end
  
  def bd_initials
    business_developer.initials
  end
  
end
