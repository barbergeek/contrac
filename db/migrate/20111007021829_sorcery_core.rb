class SorceryCore < ActiveRecord::Migration
  def self.up
    # migrate to sorcery
    add_column :users, :crypted_password, :string, :default => nil
    add_column :users, :salt, :string, :default => nil

    remove_column :users, :password_digest, :string
    
    #reset password
    User.all.each do |u|
      u.password = 'foo123'
      u.save!
    end

  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :salt
    
    add_column :users, :password_digest, :string
    
    #reset password
    User.all.each do |u|
      u.password = 'foo123'
      u.save!
    end
    
  end
end