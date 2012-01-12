class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :notes
      t.integer :owner_id
      t.integer :opportunity_id
      t.string :status
      t.datetime :due_at
      t.datetime :closed_at
      t.integer :assigned_by

      t.timestamps
    end
  end
end
