class AddColumnsToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :priority, :integer
    add_column :opportunities, :solicitation, :string
    add_column :opportunities, :solicitation_source, :string
    add_column :opportunities, :vehicle, :string
  end

  def self.down
    remove_column :opportunities, :vehicle
    remove_column :opportunities, :solicitation_source
    remove_column :opportunities, :solicitation
    remove_column :opportunities, :priority
  end
end
