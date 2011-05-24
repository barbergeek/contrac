class RemoveTagsFromCompanies < ActiveRecord::Migration
  def self.up
    remove_column :companies, :tags
  end

  def self.down
    add_column :companies, :tags, :string
  end
end
