class AddSearchSinkToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :search_sink, :text
  end

  def self.down
    remove_column :opportunities, :search_sink
  end
end
