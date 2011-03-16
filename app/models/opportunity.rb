# == Schema Information
# Schema version: 20110315145530
#
# Table name: opportunities
#
#  id                :integer         not null, primary key
#  acronym           :string(255)
#  program           :string(255)
#  department        :string(255)
#  agency            :string(255)
#  description       :text
#  location          :string(255)
#  input_record_id   :integer
#  total_value       :integer
#  win_probability   :integer
#  contract_length   :string(255)
#  solicitation_type :string(255)
#  contract_type     :string(255)
#  rfp_release_date  :date
#  rfp_due_date      :date
#  award_date        :date
#  prime             :string(255)
#  capture_phase     :string(255)
#  owner_id          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  input_status      :string(255)
#  acquisition_url   :string(255)
#  outcome           :string(255)
#  our_value         :integer
#

class Opportunity < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :comments, :as => :commentable
  belongs_to :input_record, :primary_key => "opportunity_id", :readonly => :true
  has_many :watched_opportunities
  has_many :watchers, :through => :watched_opportunities, :source => :user
  
  delegate  :name,
            :initials,
            :to => :owner,
            :prefix => true
            
  attr_accessible :acronym, :program, :department, :agency, :description, :location,
                  :input_number, :total_value, :win_probability, :contract_length, :solicitation_type,
                  :contract_type, :rfp_release_date, :rfp_due_date, :award_date, :prime, :capture_phase, 
                  :input_status, :owner_id, :acquisition_url, :comments, :comments_attributes, :outcome,
                  :our_value, :watchers, :owner, :watched_opportunities
                  
  accepts_nested_attributes_for :comments, :reject_if => proc { |attributes| attributes['content'].blank? }
  
  validates :program, :presence => true
  validates :department, :presence => true

  PHASES = %w[identification qualification win_strategy pre-proposal proposal post_submittal post_award]
  OUTCOMES = %w[won lost no_bid]
  
  scope :calendar,
     where("(outcome <> ? or outcome is null) and (capture_phase not in (?) or capture_phase is null) and rfp_release_date is not null and (input_status is null or input_status not in (?))", "no_bid", %w[post_submittal post_award], %w[Post-RFP Awarded])
     # where (outcome <> 'no_bid' or outcome is null) and (capture_phase not in ('post_submittal','post_award') or capture_phase is null) and rfp_release_date is not null;

  scope :unawarded,
    where("(outcome is null or outcome = '') and rfp_release_date is not null and (input_status is null or input_status not in (?))", ["Awarded","Deleted/Canceled"])
 
  scope :pre_rfp,
    where("(outcome is null or outcome = '') and rfp_release_date is not null and (input_status is null or input_status in (?)) and (capture_phase is null or capture_phase not in (?))", ["Pre-RFP","Forecast Pre-RFP"], %w[post_submittal post_award])

  scope :lost,
    where("outcome = 'lost'")
  
  scope :won,
    where("outcome = 'won'")
    
  def watched_by?(who)
    watchers.include?(who)
  end
  
  def owned_by?(who)
    owner == who
  end
  
  def self.department_count
    count(:all, :group => "department")
  end
    
  def self.input_status_count
    count(:all, :group => "input_status")
  end
  
  def self.for(who)
    where("owner_id = ?",who.id)
  end
  
  def self.recently_updated(since = 7.days.ago)
    where("updated_at > ?",since)
  end
  
  def self.program_and_rfp_date
    select("id,program,rfp_release_date")
  end

  def self.program_and_update_date
    select("id,program,updated_at AS update_date")
  end
  
  def self.by_rfp_date
    order("rfp_release_date asc")
  end
  
  def self.by_updated_desc
    order("updated_at desc")
  end
  
  def self.by_program
    order("program")
  end
  
end
