class TodoController < ApplicationController
  def index
    @todos = Todo.find(:all, :order=>:id)
  end
  def add
    todo = Todo.create(:subject=>params[:subject], :created_at=>Time.now)
    render :json=>todo
  end
  def start
    todo = Todo.find(params[:id])
    todo.mark_as_started
    todo.save
    render :json=>todo
  end
  def complete
    todo = Todo.find(params[:id])
    todo.mark_as_completed
    todo.save
    render :json=>todo
  end
end
