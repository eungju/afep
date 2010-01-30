class TaskController < ApplicationController
  def index
    @recent_closed_marks = ClosedMark.find_recent_two
    @tasks = Task.find(:all, :order=>:id)
  end
  def add
    task = ActiveList.new.add(params[:subject])
    render :json=>task
  end
  def start
    task = Task.find(params[:id].to_i)
    task.mark_as_started
    task.save!
    render :json=>task
  end
  def complete
    task = Task.find(params[:id].to_i)
    task.mark_as_completed
    task.save!
    render :json=>task
  end
  def close_list
    uncompleted_task = CompletedList.new.find_uncompleted_task
    if uncompleted_task
      render :status=>403, :text=>"닫힌 작업 목록에 검토하지 않은 작업이 남아 있습니다."
    else
      closed_mark = ActiveList.new.close
      render :json=>closed_mark
    end
  end
end
