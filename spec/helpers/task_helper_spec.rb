require 'spec_helper'

describe TaskHelper do

  it "should know proper css class name of the task" do
    working_list = mock(WorkingList)
    working_list.stub!(:has_closed_list).and_return(false)
    working_list.stub!(:has_completely_closed_list).and_return(false)
    assigns[:working_list] = working_list

    task = Task.new(:subject=>"something", :created_at=>Time.now)
    helper.item_class_of_task(task).should eql("todo")
    task.mark_as_started
    helper.item_class_of_task(task).should eql("started")
    task.mark_as_completed
    helper.item_class_of_task(task).should eql("completed")
  end

end
