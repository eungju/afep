class TaskController < ApplicationController
  def index
    @recent_closed_marks = ClosedMark.find(:all, :order=>"task_id DESC", :limit=>2)
    @tasks = Task.find(:all, :order=>:id)
  end
  def add
    task = Task.create(:subject=>params[:subject], :created_at=>Time.now)
    render :json=>task
  end
  def start
    task = Task.find(params[:id].to_i)
    task.mark_as_started
    task.save
    render :json=>task
  end
  def complete
    task = Task.find(params[:id].to_i)
    task.mark_as_completed
    task.save
    render :json=>task
  end
  def close_list
    closed_mark = ClosedMark.create(:task_id=>params[:task_id].to_i)
    render :json=>closed_mark
  end
end
