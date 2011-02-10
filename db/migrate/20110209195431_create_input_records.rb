class CreateInputRecords < ActiveRecord::Migration
  def self.up
    create_table :input_records do |t|
      t.string :acronym
      t.string :title
      t.string :organization
      t.string :rfp_number
      t.string :program_value
      t.string :rfp_date
      t.string :status
      t.string :user_list
      t.string :project_award_date
      t.string :opportunity_id
      t.string :contract_type
      t.string :contract_type_combined
      t.string :primary_service
      t.string :contract_duration
      t.string :last_updated
      t.string :competition_type
      t.string :naics
      t.string :primary_state_of_performance
      t.string :summary
      t.string :comments
      t.string :dod_civil
      t.string :incumbent
      t.string :contractor_combined
      t.string :incumbent_value
      t.string :incumbent_contract_number
      t.string :incumbent_award_date
      t.string :incumbent_expire_date
      t.string :priority
      t.string :vertical
      t.string :vertical_combined
      t.string :segment
      t.string :segment_combined
      t.string :key_contacts

      t.timestamps
    end
  end

  def self.down
    drop_table :input_records
  end
end
