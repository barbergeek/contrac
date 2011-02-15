class AddInputStatusToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :input_status, :string
  end

  def self.down
    remove_column :opportunities, :input_status
  end
end
