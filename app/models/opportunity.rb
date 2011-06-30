# == Schema Information
# Schema version: 20110506142811
#
# Table name: opportunities
#
#  id                       :integer         not null, primary key
#  acronym                  :string(255)
#  program                  :string(255)
#  department               :string(255)
#  agency                   :string(255)
#  description              :text
#  location                 :string(255)
#  input_opportunity_number :integer
#  total_value              :integer
#  win_probability          :integer
#  contract_length          :string(255)
#  solicitation_type        :string(255)
#  contract_type            :string(255)
#  rfp_release_date         :date
#  rfp_due_date             :date
#  award_date               :date
#  prime                    :string(255)
#  capture_phase            :string(255)
#  business_developer_id    :integer
#  created_at               :datetime
#  updated_at               :datetime
#  input_status             :string(255)
#  acquisition_url          :string(255)
#  outcome                  :string(255)
#  our_value                :integer
#  search_sink              :text
#  capture_manager_id       :integer
#  ignored                  :boolean         not null
#  priority                 :integer
#  solicitation             :string(255)
#  solicitation_source      :string(255)
#  vehicle                  :string(255)
#

class Opportunity < ActiveRecord::Base
  belongs_to :business_developer, :class_name => "User"
  belongs_to :capture_manager, :class_name => "User"
  has_many :comments, :as => :commentable
  belongs_to :input_record, :foreign_key => "input_opportunity_number",
              :primary_key => "input_opportunity_number", :readonly => :true
  has_many :watched_opportunities
  has_many :watchers, :through => :watched_opportunities, :source => :user

  delegate  :name,
            :initials,
            :to => :business_developer,
            :prefix => true

  delegate  :name,
            :initials,
            :to => :capture_manager,
            :prefix => true

  attr_accessible :acronym, :program, :department, :agency, :description, :location,
                  :input_number, :total_value, :win_probability, :contract_length, :solicitation_type,
                  :contract_type, :rfp_release_date, :rfp_due_date, :award_date, :prime, :capture_phase,
                  :input_status, :business_developer_id, :capture_manager_id, :acquisition_url, :comments, :comments_attributes, :outcome,
                  :our_value, :watchers, :business_developer, :capture_manager, :watched_opportunities, 
                  :input_opportunity_number, :rfp_expected_due_date, :priority, :solicitation,
                  :solicitation_source, :vehicle

  accepts_nested_attributes_for :comments, :reject_if => proc { |attributes| attributes['content'].blank? }

  before_save :set_expected_due_date
  before_save :fill_search_sink

  validates :program, :presence => true
  validates :department, :presence => true

  default_scope where(:ignored => false)
  
  PHASES = %w[identification qualification win_strategy pre-proposal proposal post_submittal post_award]
  OUTCOMES = %w[won lost no_bid]
  PRIORITIES = [["High",1],["Medium",2],["Low",3]]
  VEHICLES = ["Full and Open","AF ICE2","AF NETCENTS","DHS EAGLE","DHS USVISIT","DIA SIA","DIA SITE",
    "ENCORE II","JSIN","GSA Alliant","GSA Schedule","CEOSS","Seaport-E","CIO-SP2","ITES-2S","New IDIQ"]
  SOURCES = %w[FBO HERBB FAACO Unknown/Other]

  scope :calendar,
     where("(outcome <> ? or outcome is null) and (capture_phase not in (?) or capture_phase is null) and rfp_release_date is not null and (input_status is null or input_status not in (?))", "no_bid", %w[post_submittal post_award], %w[Post-RFP Awarded])
     # where (outcome <> 'no_bid' or outcome is null) and (capture_phase not in ('post_submittal','post_award') or capture_phase is null) and rfp_release_date is not null;

  scope :unawarded,
    where("(outcome is null or outcome = '') and rfp_release_date is not null and (input_status is null or input_status not in (?))", ["Awarded","Deleted/Canceled"])

  scope :with_capture_phase,
    where("capture_phase is not null and capture_phase <> ''")

  scope :pre_rfp,
    where("(outcome is null or outcome = '') and rfp_release_date is not null and (capture_phase is null or capture_phase not in (?)) and (input_status is null or input_status not in (?))", %w[post_submittal post_award], ["Awarded","Deleted/Canceled","Source Selection","Umbrella Program","Protest"])

  scope :lost,
    where("outcome = 'lost'")

  scope :won,
    where("outcome = 'won'")

  scope :with_input_records
    where("input_opportunity_number is not null")

  def self.exclude_outcomes(outcome)
    where("outcome not in (?) or outcome is null", outcome)
  end

  def self.my_updated(who,since)
    includes([:business_developer, :capture_manager, :watchers]).where("(business_developer_id = #{who.id} or capture_manager_id = #{who.id} or watched_opportunities.user_id = #{who.id}) and opportunities.updated_at > ?",since)
  end
  
  def destroy
    self.ignored = true
    save!
  end
  
  def ignore
    self.destroy
  end
  
  def recover
    self.ignored = false
    save!
  end
  
  def ignored?
    self.ignored
  end
  
  def watched_by?(who)
    watchers.include?(who)
  end

  def owned_by?(who)
    business_developer == who || capture_manager == who
  end

  def title
    acronym.blank? ? program : acronym
  end

  def rfp_expected_due_date
    rfp_due_date || (rfp_release_date + 1.month unless rfp_release_date.nil?)
  end

  def rfp_expected_due_date=(duedate)
    self.rfp_due_date = duedate
  end

  def rfp_date(which)
    if which == :due_date
      rfp_due_date
    else
      rfp_release_date
    end
  end

  def self.department_count
    count(:all, :group => "department")
  end

  def self.input_status_count
    count(:all, :group => "input_status")
  end

  def self.capture_phase_count
    count(:all, :group => "capture_phase")
  end

  def self.for(who)
    where("business_developer_id = ? or capture_manager_id = ?",who.id,who.id)
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

  def find_input_comment(comment)
    comments.find_by_content_and_source(comment, "INPUT")
  end

  def new_input_comment=(comment)
    comments << Comment.new(:content => comment, :source => "INPUT") unless find_input_comment(comment)
  end

  def new_input_comment_with_date(comment,date)
    comments << Comment.new(:content => comment, :source => "INPUT", :commented_at => date) unless find_input_comment(comment)
  end

  def self.search(string)
    if string.blank?
      all
    elsif is_a_number?(string)
      where("input_opportunity_number = ?",string)
    else
      where("search_sink like ?","%#{string.downcase}%")
    end
  end

  def fill_search_sink
    self.search_sink = [acronym, program, description, input_opportunity_number, solicitation_type, contract_type, prime].collect {|item| item.to_s.strip.downcase}.join('||')
  end

  def toggle_watch(who)
    if watched_by?(who)
      unwatch(who)
    else
      watch(who)
    end
    save!
  end

  def watch(who)
    watchers << who
    save!
  end

  def unwatch(who)
    watchers.delete(who)
    save!
  end

  def own(who)
    if who.capture_manager?
      self.capture_manager = who
    elsif who.bd?
      self.business_developer = who
    else
      self.capture_manager = who
    end
    save!
  end

  def own_or_watch(who)
    if capture_manager.nil? && who.capture_manager?
      own(who)
    elsif business_developer.nil? && who.bd?
      own(who)
    else
      watch(who)
    end
  end

  protected

    def set_expected_due_date
      self.rfp_due_date = rfp_due_date || (rfp_release_date + 1.month unless rfp_release_date.nil?)
    end

    def self.is_a_number?(s)
      s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end

end

