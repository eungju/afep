module TaskHelper
  def class_for_task_state(task)
    if task.done?
      "done"
    elsif task.doing?
      "doing"
    elsif task.todo?
      "todo"
    elsif task.canceled?
      "canceled"
    end
  end
  def class_for_closed_mark(task)
    if @working_list.has_closed_list and task.id == @working_list.closed_mark.task_id
      "closed_mark"
    elsif @working_list.has_completely_closed_list and task.id == @working_list.completely_closed_mark.task_id
      "completely_closed_mark"
    else
      ""
    end
  end
  def class_for_review(task)
    if @working_list.has_completely_closed_list and task.id <= @working_list.completely_closed_mark.task_id and not task.completed?
      "review"
    else
      ""
    end
  end
  def item_class_of_task(task)
    ([class_for_task_state(task), class_for_closed_mark(task), class_for_review(task)].reject { |e| e == "" }).join " "
  end
  def htmlize_subject(subject)
    auto_link(h(subject))
  end
end
