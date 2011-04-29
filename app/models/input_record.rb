# == Schema Information
# Schema version: 20110329184645
#
# Table name: input_records
#
#  id                           :integer         not null, primary key
#  acronym                      :string(255)
#  title                        :string(255)
#  organization                 :string(255)
#  rfp_number                   :string(255)
#  program_value                :string(255)
#  rfp_date                     :string(255)
#  status                       :string(255)
#  user_list                    :string(255)
#  project_award_date           :string(255)
#  contract_type                :string(255)
#  primary_service              :string(255)
#  contract_duration            :string(255)
#  last_updated                 :string(255)
#  competition_type             :string(255)
#  naics                        :string(255)
#  primary_state_of_performance :string(255)
#  dod_civil                    :string(255)
#  incumbent                    :string(255)
#  incumbent_value              :string(255)
#  incumbent_contract_number    :string(255)
#  incumbent_award_date         :string(255)
#  incumbent_expire_date        :string(255)
#  priority                     :string(255)
#  vertical                     :string(255)
#  segment                      :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  input_url                    :string(255)
#  comments                     :text
#  summary                      :text
#  contract_type_combined       :text
#  contractor_combined          :text
#  vertical_combined            :text
#  segment_combined             :text
#  key_contacts                 :text
#  input_opportunity_number     :integer
#

class InputRecord < ActiveRecord::Base
  has_one :opportunity, :foreign_key => "input_opportunity_number", :primary_key => "input_opportunity_number"
  has_many :news_items, :class_name => "Comment", :as => :commentable

  def find_news_item(comment)
    news_items.find_by_content_and_source(comment, "INPUT")
  end
  
  def new_news=(comment)
    news_items << Comment.new(:content => comment, :source => "INPUT") unless find_news_item(comment)
  end
  
  def new_news_with_date(comment,date)
    news_items << Comment.new(:content => comment, :source => "INPUT", :commented_at => date) unless find_news_item(comment)
  end
  
  def merge_to_opportunity

    if organization =~ /\//
      dept,agency = organization.split("/")
    else
      dept = organization
      agency = nil
    end
    
    create_opportunity(:program => title, :department => dept) if opportunity.nil?

    # merge missing data
    opportunity.acronym = acronym if opportunity.acronym.blank?
    opportunity.agency = agency if opportunity.agency.blank?
    opportunity.description = summary if opportunity.description.blank?
    opportunity.location = primary_state_of_performance if opportunity.location.blank?
    opportunity.total_value = program_value if opportunity.total_value.blank?
    opportunity.contract_length = contract_duration if opportunity.contract_length.blank?
    opportunity.solicitation_type = competition_type if opportunity.solicitation_type.blank?
    opportunity.contract_type = contract_type if opportunity.contract_type.blank?

    # for now, always take these fields from input
    opportunity.rfp_release_date = rfp_date if opportunity.rfp_release_date != rfp_date
    opportunity.award_date = project_award_date if opportunity.award_date != project_award_date
    opportunity.input_status = status if opportunity.input_status != status
    # opportunity.rfp_release_date = rfp_date if opportunity.rfp_release_date.blank? && !rfp_date.blank?
    #  rfp_due_date          :date
  
    #opportunity.new_input_comment = comments
    #store the "news" in input_record now, not attached to the opportunity
    
    # save it
    opportunity.save!

    # give ownership or watch to users
    user_list.split(", ").each do |email|
      user = User.find_by_email(email)
      opportunity.own_or_watch(user) unless user.nil?
    end unless user_list.nil?

  end
  
end
