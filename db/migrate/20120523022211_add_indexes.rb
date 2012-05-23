class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, :id, unique: :true
    add_index :watched_opportunities, :id, unique: :true
    add_index :watched_opportunities, :opportunity_id
    add_index :opportunities, :id, unique: :true
    add_index :opportunities, :ignored
  end

end
