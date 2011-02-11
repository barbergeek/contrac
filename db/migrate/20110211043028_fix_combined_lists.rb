class FixCombinedLists < ActiveRecord::Migration
  def self.up
        remove_column :input_records, :contract_type_combined
        add_column :input_records, :contract_type_combined, :text

        remove_column :input_records, :contractor_combined
        add_column :input_records, :contractor_combined, :text

        remove_column :input_records, :vertical_combined
        add_column :input_records, :vertical_combined, :text

        remove_column :input_records, :segment_combined
        add_column :input_records, :segment_combined, :text
      end

      def self.down
        remove_column :input_records, :contract_type_combined
        add_column :input_records, :contract_type_combined, :string

        remove_column :input_records, :contractor_combined
        add_column :input_records, :contractor_combined, :string

        remove_column :input_records, :vertical_combined
        add_column :input_records, :vertical_combined, :string

        remove_column :input_records, :segment_combined
        add_column :input_records, :segment_combined, :string
     end
    end
