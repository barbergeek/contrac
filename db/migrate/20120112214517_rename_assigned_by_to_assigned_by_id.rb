class RenameAssignedByToAssignedById < ActiveRecord::Migration
  def up
    rename_column :tasks, :assigned_by, :assigned_by_id
  end

  def down
    rename_column :tasks, :assigned_by_id, :assigned_by
  end
end
