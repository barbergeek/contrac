class RenameIgnoreToIgnoredOnOpportunities < ActiveRecord::Migration
  def self.up
    rename_column :opportunities, :ignore, :ignored
  end

  def self.down
    rename_column :opportunities, :ignored, :ignore
  end
end
