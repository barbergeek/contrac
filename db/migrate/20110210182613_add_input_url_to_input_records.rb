class AddInputUrlToInputRecords < ActiveRecord::Migration
  def self.up
    add_column :input_records, :input_url, :string
  end

  def self.down
    remove_column :input_records, :input_url
  end
end
