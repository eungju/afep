class CreateClosedMarks < ActiveRecord::Migration
  def self.up
    create_table :closed_mark do |t|
      t.integer :todo_id, :null=>false
    end
  end

  def self.down
    drop_table :closed_mark
  end
end
