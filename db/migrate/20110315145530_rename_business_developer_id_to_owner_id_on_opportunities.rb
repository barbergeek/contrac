class RenameBusinessDeveloperIdToOwnerIdOnOpportunities < ActiveRecord::Migration
  def self.up
    rename_column :opportunities, :business_developer_id, :owner_id
  end

  def self.down
    rename_column :opportunities, :owner_id, :business_developer_id
  end
end
