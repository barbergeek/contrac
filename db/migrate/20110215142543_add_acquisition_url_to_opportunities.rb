class AddAcquisitionUrlToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :acquisition_url, :string
  end

  def self.down
    remove_column :opportunities, :acquisition_url
  end
end
