class AddIgnoreToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :ignore, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :opportunities, :ignore
  end
end
