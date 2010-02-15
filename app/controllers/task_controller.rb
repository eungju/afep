# -*- coding: utf-8 -*-

class TaskController < ApplicationController
  def index
    @working_list = WorkingList.new
  end
  def add
    task = ActiveList.new.add(params[:subject])
    redirect_to :action=>:index, :anchor => "task_#{task.id}"
  end
  def start
    task = Task.find(params[:id].to_i)
    task.mark_as_started
    task.save!
    redirect_to :action=>:index, :anchor => "task_#{task.id}"
  end
  def complete
    task = Task.find(params[:id].to_i)
    task.mark_as_completed
    task.save!
    redirect_to :action=>:index, :anchor => "task_#{task.id}"
  end
  def cancel
    task = Task.find(params[:id].to_i)
    task.mark_as_canceled
    task.save!
    redirect_to :action=>:index, :anchor => "task_#{task.id}"
  end
  def close_list
    uncompleted_task = CompletedList.new.find_uncompleted_task
    if uncompleted_task
      flash[:error] = "닫힌 작업 목록에 검토하지 않은 작업이 남아 있습니다."
    else
      closed_mark = ActiveList.new.close
    end
    redirect_to :action=>:index
  end
end
