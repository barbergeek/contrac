class ChangeCommentType < ActiveRecord::Migration
  def self.up
    remove_column :input_records, :comments
    add_column :input_records, :comments, :text
  end

  def self.down
    remove_column :input_records, :comments
    add_column :input_records, :comments, :string
  end
end
