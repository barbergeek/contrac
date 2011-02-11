class ChangeSummaryType < ActiveRecord::Migration
    def self.up
      remove_column :input_records, :summary
      add_column :input_records, :summary, :text
    end

    def self.down
      remove_column :input_records, :summary
      add_column :input_records, :summary, :string
    end
  end
