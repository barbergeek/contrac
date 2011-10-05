class RemoveDeviseFields < ActiveRecord::Migration
  def up
    #remove Devise fields
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :remember_token
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :password_salt
    
    #add Rails 3.1 has_secure_password fields
    add_column :users, :password_digest, :string
    
    #reset password
    User.all.each do |u|
      u.password = 'foo123'
      u.save!
    end
    
  end

  def down
    
    remove_column :users, :password_digest
    
#    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
#    t.string   "reset_password_token"
#    t.string   "remember_token"
#    t.datetime "remember_created_at"
#    t.integer  "sign_in_count",                       :default => 0
#    t.datetime "current_sign_in_at"
#    t.datetime "last_sign_in_at"
#    t.string   "current_sign_in_ip"
#    t.string   "last_sign_in_ip"
    add_column :users, :encrypted_password, :string, :limit => 128, :default => "", :null => false
    add_column :users, :password_salt, :string
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_created_at, :datetime
    add_column :users, :sign_in_count, :integer, :default => 0
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    
    
  end
end
