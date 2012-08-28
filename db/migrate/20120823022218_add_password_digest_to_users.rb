class AddPasswordDigestToUsers < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
    add_column :users, :sso, :boolean
    remove_column :users, :crypted_password
    remove_column :users, :salt
  end

  def down
    remove_column :users, :password_digest
    remove_column :users, :sso
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string
  end

end
