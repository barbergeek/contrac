class ChangeDueAtToDueDate < ActiveRecord::Migration
  def up
    remove_column :tasks, :due_at
    remove_column :tasks, :closed_at
    add_column :tasks, :due_date, :date
    add_column :tasks, :status_date, :date
    add_column :tasks, :status_notes, :text
  end

  def down
    remove_column :tasks, :due_date
    remove_column :tasks, :status_date
    remove_column :tasks, :status_notes
    add_column :tasks, :due_at, :datetime
    add_column :tasks, :closed_at, :datetime
  end
end
