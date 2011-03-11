class AddFormattedTextToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :formatted_text, :text
  end

  def self.down
    remove_column :announcements, :formatted_text
  end
end
