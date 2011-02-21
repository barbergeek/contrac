class RemoveCommentsFromOpportunties < ActiveRecord::Migration
  def self.up
    remove_column :opportunities, :comments
  end

  def self.down
    add_column :opportunities, :comments, :text
  end
end
