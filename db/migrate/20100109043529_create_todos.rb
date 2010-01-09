class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todo do |t|
      t.string :subject, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :started_at
      t.timestamp :completed_at
    end
  end

  def self.down
    drop_table :todo
  end
end
