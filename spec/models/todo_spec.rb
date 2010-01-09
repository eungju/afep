require 'spec_helper'

describe Todo do
  before(:each) do
    @valid_attributes = {
      :subject=>"Something",
      :created_at=>Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Todo.create!(@valid_attributes)
  end
  
  it "should be marked as started and then completed" do
    todo = Todo.create(@valid_attributes)
    todo.mark_as_started
    todo.started_at.should_not be_nil
    todo.started?.should be_true
    
    todo.mark_as_completed
    todo.completed_at.should_not be_nil
    todo.completed?.should be_true
  end
end
