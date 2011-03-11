class AddOurValueToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :our_value, :integer
  end

  def self.down
    remove_column :opportunities, :our_value
  end
end
