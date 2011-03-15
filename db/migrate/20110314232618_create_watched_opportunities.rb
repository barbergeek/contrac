class CreateWatchedOpportunities < ActiveRecord::Migration
  def self.up
    create_table :watched_opportunities do |t|
      t.integer :opportunity_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :watched_opportunities
  end
end
