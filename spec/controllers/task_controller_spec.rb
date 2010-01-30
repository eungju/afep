require 'spec_helper'

describe TaskController do

  it "should show all tasks" do
    recent_closed_marks = []
    ClosedMark.should_receive(:find_recent_two).with().and_return(recent_closed_marks)
    tasks = []
    Task.should_receive(:find).with(:all, :order=>:id).and_return(tasks)
    
    get :index
    response.should be_success
    assigns[:tasks].should eql(tasks)
  end
  
  it "should add a task" do 
    subject = "blah"
    active_list = mock(ActiveList)
    task = mock_model(Task)
    ActiveList.should_receive(:new).and_return(active_list)
    active_list.should_receive(:add).with(subject).and_return(task)
    task.should_receive(:to_json).and_return("{}")

    post :add, :subject=>subject
    response.should be_success
  end
  
  it "should start a task" do
    task_id = 1
    task = mock_model(Task)
    Task.should_receive(:find).with(task_id).and_return(task)
    task.should_receive(:mark_as_started)
    task.should_receive(:save!)
    task.should_receive(:to_json).and_return("{}")

    post :start, :id=>task_id.to_s
    response.should be_success
  end

  it "should complete a task" do
    task_id = 1
    task = mock_model(Task)
    Task.should_receive(:find).with(task_id).and_return(task)
    task.should_receive(:mark_as_completed)
    task.should_receive(:save!)
    task.should_receive(:to_json).and_return("{}")

    post :complete, :id=>task_id.to_s
    response.should be_success
  end

  it "should close the active list and open new one" do
    task_id = 1
    active_list = mock(ActiveList)
    closed_mark = mock_model(ClosedMark)
    ActiveList.should_receive(:new).and_return(active_list)
    active_list.should_receive(:close).and_return(closed_mark)
    closed_mark.should_receive(:to_json).and_return("{}")

    post :close_list, :task_id=>task_id.to_s
    response.should be_success
  end

  it "should not close the active list when completely-closed list has any uncompleted task" do
    completed_list = mock(CompletedList)
    uncompleted_task = mock_model(Task)
    CompletedList.should_receive(:new).and_return(completed_list)
    completed_list.should_receive(:find_uncompleted_task).and_return(uncompleted_task)
    task_id = 123
    post :close_list, :task_id=>task_id.to_s
    #response.should be_forbidden
  end

end
