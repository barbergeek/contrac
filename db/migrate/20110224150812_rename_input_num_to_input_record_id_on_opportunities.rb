class RenameInputNumToInputRecordIdOnOpportunities < ActiveRecord::Migration
  def self.up
    rename_column :opportunities, :input_number, :input_record_id
  end

  def self.down
    rename_column :opportunities, :input_record_id, :input_number
  end
end
