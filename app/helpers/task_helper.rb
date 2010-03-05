require 'kramdown'

module TaskHelper
  def class_for_task_state(task)
    if task.completed?
      "done"
    elsif task.started?
      "doing"
    else
      "todo"
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
  def markdown(text)
    Kramdown::Document.new(text).to_html
  end
end
