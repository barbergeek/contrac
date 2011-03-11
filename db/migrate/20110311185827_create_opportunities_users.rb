class CreateOpportunitiesUsers < ActiveRecord::Migration
  def self.up
    create_table :opportunities_users, :id => false do |t|
      t.integer :opportunity_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :opportunities_users
  end
end
