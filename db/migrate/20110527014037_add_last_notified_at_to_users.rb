class AddLastNotifiedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_notified_at, :datetime
  end

  def self.down
    remove_column :users, :last_notified_at
  end
end
