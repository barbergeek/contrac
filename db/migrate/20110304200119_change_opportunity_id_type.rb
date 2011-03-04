class ChangeOpportunityIdType < ActiveRecord::Migration
  def self.up
    remove_column :input_records, :opportunity_id
    add_column :input_records, :opportunity_id, :integer
  end

  def self.down
    remove_column :input_records, :opportunity_id
    add_column :input_records, :opportunity_id, :string
  end
end
