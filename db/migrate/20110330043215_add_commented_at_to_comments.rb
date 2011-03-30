class AddCommentedAtToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :commented_at, :datetime
  end

  def self.down
    remove_column :comments, :commented_at
  end
end
