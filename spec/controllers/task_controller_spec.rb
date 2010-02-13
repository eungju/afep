require 'spec_helper'

describe TaskController do

  it "should show working list" do
    working_list = mock(WorkingList)
    WorkingList.should_receive(:new).and_return(working_list)
    
    get :index
    response.should be_success
    assigns[:working_list].should equal(working_list)
  end
  
  it "should add a task" do 
    subject = "blah"
    active_list = mock(ActiveList)
    task = mock_model(Task)
    ActiveList.should_receive(:new).and_return(active_list)
    active_list.should_receive(:add).with(subject).and_return(task)

    post :add, :subject=>subject
    response.should redirect_to(:action=>:index, :anchor=>"task_#{task.id}")
  end
  
  it "should start a task" do
    task = mock_model(Task)
    Task.should_receive(:find).with(task.id).and_return(task)
    task.should_receive(:mark_as_started)
    task.should_receive(:save!)

    post :start, :id=>task.id.to_s
    response.should redirect_to(:action=>:index, :anchor=>"task_#{task.id}")
  end

  it "should complete a task" do
    task = mock_model(Task)
    Task.should_receive(:find).with(task.id).and_return(task)
    task.should_receive(:mark_as_completed)
    task.should_receive(:save!)

    post :complete, :id=>task.id.to_s
    response.should redirect_to(:action=>:index, :anchor=>"task_#{task.id}")
  end

  it "should close the active list and open new one" do
    task_id = 1
    active_list = mock(ActiveList)
    closed_mark = mock_model(ClosedMark)
    ActiveList.should_receive(:new).and_return(active_list)
    active_list.should_receive(:close).and_return(closed_mark)

    post :close_list, :task_id=>task_id.to_s
    response.should redirect_to(:action=>:index)
  end

  it "should not close the active list when completely-closed list has any uncompleted task" do
    completed_list = mock(CompletedList)
    uncompleted_task = mock_model(Task)
    CompletedList.should_receive(:new).and_return(completed_list)
    completed_list.should_receive(:find_uncompleted_task).and_return(uncompleted_task)
    task_id = 123
    post :close_list, :task_id=>task_id.to_s
    response.should redirect_to(:action=>:index)
  end

end
