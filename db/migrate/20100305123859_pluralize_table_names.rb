class PluralizeTableNames < ActiveRecord::Migration
  def self.up
    rename_table :task, :tasks
    rename_table :closed_mark, :closed_marks
  end

  def self.down
    rename_table :closed_marks, :closed_mark
    rename_table :tasks, :task
  end
end
