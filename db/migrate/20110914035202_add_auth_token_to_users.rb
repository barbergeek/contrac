class AddAuthTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :auth_token, :string
    
    #User.all.each do |u|
    #  u.generate_token(:auth_token)
    #  u.save!
    #end
  end
  
  def down
    remove_column :users, :auth_token
  end
  
end
