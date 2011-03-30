class RenameInputOpportunityId < ActiveRecord::Migration
  def self.up
    rename_column :opportunities, :input_record_id, :input_opportunity_number
    rename_column :input_records, :opportunity_id, :input_opportunity_number
  end

  def self.down
    rename_column :opportunities, :input_opportunity_number, :input_record_id
    rename_column :input_records, :input_opportunity_number, :opportunity_id
  end
end
