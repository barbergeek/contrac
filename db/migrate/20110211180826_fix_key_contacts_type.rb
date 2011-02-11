class FixKeyContactsType < ActiveRecord::Migration
  def self.up
    remove_column :input_records, :key_contacts
    add_column :input_records, :key_contacts, :text
  end

  def self.down
    remove_column :input_records, :key_contacts
    add_column :input_records, :key_contacts, :string
  end
end
