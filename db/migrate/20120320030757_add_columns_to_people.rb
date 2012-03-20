class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :firstname, :string

    add_column :people, :lastname, :string

    add_column :people, :nickname, :string

    add_column :people, :rank, :string

    add_column :people, :service, :string

  end
end
