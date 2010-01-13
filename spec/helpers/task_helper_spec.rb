require 'spec_helper'

describe TaskHelper do

  it "should know proper css class name of the task" do
    assigns[:recent_closed_marks] = []
    task = Task.new(:subject=>"something", :created_at=>Time.now)
    helper.item_class_of_task(task).should eql("todo")
    task.mark_as_started
    helper.item_class_of_task(task).should eql("started")
    task.mark_as_completed
    helper.item_class_of_task(task).should eql("completed")
  end

end
