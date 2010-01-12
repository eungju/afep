module TodoHelper
  def has_closed_list
    @recent_closed_marks.size >= 1
  end
  def has_completely_closed_list
    @recent_closed_marks.size >= 2
  end
  def class_for_todo_state(todo)
    if todo.completed?
      "completed"
    elsif todo.started?
      "started"
    else
      "todo"
    end
  end
  def class_for_closed_mark(todo)
    if has_closed_list and todo.id == @recent_closed_marks[0].todo_id
      "closed_mark"
    elsif has_completely_closed_list and todo.id == @recent_closed_marks[1].todo_id
      "completely_closed_mark"
    else
      ""
    end
  end
  def item_class_of_todo(todo)
    [class_for_todo_state(todo), class_for_closed_mark(todo)].join " "
  end
end
