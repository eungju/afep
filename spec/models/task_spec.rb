require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      :subject=>"Something",
      :created_at=>Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
  
  it "should be marked as started and then completed" do
    task = Task.create(@valid_attributes)
    task.mark_as_started
    task.started_at.should_not be_nil
    task.started?.should be_true
    
    task.mark_as_completed
    task.completed_at.should_not be_nil
    task.completed?.should be_true
  end
end
