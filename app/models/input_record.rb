# == Schema Information
# Schema version: 20110210182613
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
#  opportunity_id               :string(255)
#  contract_type                :string(255)
#  contract_type_combined       :string(255)
#  primary_service              :string(255)
#  contract_duration            :string(255)
#  last_updated                 :string(255)
#  competition_type             :string(255)
#  naics                        :string(255)
#  primary_state_of_performance :string(255)
#  summary                      :string(255)
#  comments                     :string(255)
#  dod_civil                    :string(255)
#  incumbent                    :string(255)
#  contractor_combined          :string(255)
#  incumbent_value              :string(255)
#  incumbent_contract_number    :string(255)
#  incumbent_award_date         :string(255)
#  incumbent_expire_date        :string(255)
#  priority                     :string(255)
#  vertical                     :string(255)
#  vertical_combined            :string(255)
#  segment                      :string(255)
#  segment_combined             :string(255)
#  key_contacts                 :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  input_url                    :string(255)
#

class InputRecord < ActiveRecord::Base
end