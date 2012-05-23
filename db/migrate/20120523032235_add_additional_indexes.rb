class AddAdditionalIndexes < ActiveRecord::Migration
  def change
    add_index :opportunities, :capture_manager_id
    add_index :watched_opportunities, :user_id
    add_index :opportunities, :business_developer_id
    add_index :tasks, :owner_id
  end
end
