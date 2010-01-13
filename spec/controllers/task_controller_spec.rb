require 'spec_helper'

describe TaskController do

  it "should show all tasks" do
    recent_closed_marks = []
    ClosedMark.should_receive(:find).with(:all, :order=>"task_id DESC", :limit=>2).and_return(recent_closed_marks)
    tasks = []
    Task.should_receive(:find).with(:all, :order=>:id).and_return(tasks)
    
    get :index
    response.should be_success
    assigns[:tasks].should eql(tasks)
  end
  
  it "should add a task" do 
    subject = "blah"
    now = Time.now
    task = mock_model(Task)
    Time.stub!(:now).and_return(now)
    Task.should_receive(:create).with(:subject=>subject, :created_at=>now).and_return(task)
    task.should_receive(:to_json).and_return("{}")

    post :add, :subject=>subject
    response.should be_success
  end
  
  it "should start a task" do
    task_id = 1
    task = mock_model(Task)
    Task.should_receive(:find).with(task_id).and_return(task)
    task.should_receive(:mark_as_started)
    task.should_receive(:save)
    task.should_receive(:to_json).and_return("{}")

    post :start, :id=>task_id.to_s
    response.should be_success
  end

  it "should complete a task" do
    task_id = 1
    task = mock_model(Task)
    Task.should_receive(:find).with(task_id).and_return(task)
    task.should_receive(:mark_as_completed)
    task.should_receive(:save)
    task.should_receive(:to_json).and_return("{}")

    post :complete, :id=>task_id.to_s
    response.should be_success
  end

  it "should close the active list and open new one" do
    task_id = 1
    closed_mark = mock_model(ClosedMark)
    ClosedMark.should_receive(:create).with(:task_id=>task_id).and_return(closed_mark)
    closed_mark.should_receive(:to_json).and_return("{}")

    post :close_list, :task_id=>task_id.to_s
    response.should be_success
  end

end
