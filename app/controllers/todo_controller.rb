class TodoController < ApplicationController
  def index
    @recent_closed_marks = ClosedMark.find(:all, :order=>"todo_id DESC", :limit=>2)
    @todos = Todo.find(:all, :order=>:id)
  end
  def add
    todo = Todo.create(:subject=>params[:subject], :created_at=>Time.now)
    render :json=>todo
  end
  def start
    todo = Todo.find(params[:id].to_i)
    todo.mark_as_started
    todo.save
    render :json=>todo
  end
  def complete
    todo = Todo.find(params[:id].to_i)
    todo.mark_as_completed
    todo.save
    render :json=>todo
  end
  def close_list
    closed_mark = ClosedMark.create(:todo_id=>params[:todo_id].to_i)
    render :json=>closed_mark
  end
end
