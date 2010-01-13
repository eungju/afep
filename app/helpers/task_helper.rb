module TaskHelper
  def has_closed_list
    @recent_closed_marks.size >= 1
  end
  def has_completely_closed_list
    @recent_closed_marks.size >= 2
  end
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
    if has_closed_list and task.id == @recent_closed_marks[0].task_id
      "closed_mark"
    elsif has_completely_closed_list and task.id == @recent_closed_marks[1].task_id
      "completely_closed_mark"
    elsif has_completely_closed_list and task.id <= @recent_closed_marks[1].task_id and not task.started?
      "review"
    else
      ""
    end
  end
  def item_class_of_task(task)
    ([class_for_task_state(task), class_for_closed_mark(task)].reject { |e| e == "" }).join " "
  end
end
