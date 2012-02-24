class AddRecentlyViewedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recently_viewed, :string
  end
end
