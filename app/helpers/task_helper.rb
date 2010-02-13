module TaskHelper
  def class_for_task_state(task)
    if task.completed?
      "completed"
    elsif task.started?
      "started"
    else
      "todo"
    end
  end
  def class_for_closed_mark(task)
    if @working_list.has_closed_list and task.id == @working_list.closed_mark.task_id
      "closed_mark"
    elsif @working_list.has_completely_closed_list and task.id == @working_list.completely_closed_mark.task_id
      "completely_closed_mark"
    elsif @working_list.has_completely_closed_list and task.id < @working_list.completely_closed_mark.task_id and not task.started?
      "review"
    else
      ""
    end
  end
  def item_class_of_task(task)
    ([class_for_task_state(task), class_for_closed_mark(task)].reject { |e| e == "" }).join " "
  end
end
