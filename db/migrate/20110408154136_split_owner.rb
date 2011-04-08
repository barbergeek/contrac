class SplitOwner < ActiveRecord::Migration
  def self.up
    rename_column :opportunities, :owner_id, :business_developer_id
    add_column :opportunities, :capture_manager_id, :integer
  end

  def self.down
    rename_column :opportunities, :business_developer_id, :owner_id
    drop_column :opportunities, :capture_manager_id  
  end
end
