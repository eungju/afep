require 'spec_helper'

describe TodoHelper do

  it "should know proper css class name of the todo" do
    assigns[:recent_closed_marks] = []
    todo = Todo.new(:subject=>"something", :created_at=>Time.now)
    helper.item_class_of_todo(todo).should eql("todo")
    todo.mark_as_started
    helper.item_class_of_todo(todo).should eql("started")
    todo.mark_as_completed
    helper.item_class_of_todo(todo).should eql("completed")
  end

end
