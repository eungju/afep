class RenameTodoToTask < ActiveRecord::Migration
  def self.up
    rename_table :todo, :task
    rename_column :closed_mark, :todo_id, :task_id
  end

  def self.down
    rename_column :closed_mark, :task_id, :todo_id
    rename_table :task, :todo
  end
end
