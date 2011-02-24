class AddOutcomeToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :outcome, :string
  end

  def self.down
    remove_column :opportunities, :outcome
  end
end
