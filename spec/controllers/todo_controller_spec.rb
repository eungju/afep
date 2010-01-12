require 'spec_helper'

describe TodoController do

  it "should show all todos" do
    recent_closed_marks = []
    ClosedMark.should_receive(:find).with(:all, :order=>"todo_id DESC", :limit=>2).and_return(recent_closed_marks)
    todos = []
    Todo.should_receive(:find).with(:all, :order=>:id).and_return(todos)
    
    get :index
    response.should be_success
    assigns[:todos].should eql(todos)
  end
  
  it "should add a todo" do 
    subject = "blah"
    now = Time.now
    todo = mock_model(Todo)
    Time.stub!(:now).and_return(now)
    Todo.should_receive(:create).with(:subject=>subject, :created_at=>now).and_return(todo)
    todo.should_receive(:to_json).and_return("{}")

    post :add, :subject=>subject
    response.should be_success
  end
  
  it "should start a todo" do
    todo_id = 1
    todo = mock_model(Todo)
    Todo.should_receive(:find).with(todo_id).and_return(todo)
    todo.should_receive(:mark_as_started)
    todo.should_receive(:save)
    todo.should_receive(:to_json).and_return("{}")

    post :start, :id=>todo_id.to_s
    response.should be_success
  end

  it "should complete a todo" do
    todo_id = 1
    todo = mock_model(Todo)
    Todo.should_receive(:find).with(todo_id).and_return(todo)
    todo.should_receive(:mark_as_completed)
    todo.should_receive(:save)
    todo.should_receive(:to_json).and_return("{}")

    post :complete, :id=>todo_id.to_s
    response.should be_success
  end

  it "should close the active list and open new one" do
    todo_id = 1
    closed_mark = mock_model(ClosedMark)
    ClosedMark.should_receive(:create).with(:todo_id=>todo_id).and_return(closed_mark)
    closed_mark.should_receive(:to_json).and_return("{}")

    post :close_list, :todo_id=>todo_id.to_s
    response.should be_success
  end

end
