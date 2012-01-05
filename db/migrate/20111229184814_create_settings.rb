class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
    
    Setting.reset_column_information
    Setting.input_username = nil
    Setting.input_password = nil
    
  end
  
  def down
    drop_table :settings
  end
  
end
