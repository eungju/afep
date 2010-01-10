module TodoHelper
  def item_class_of_todo(todo)
    if todo.completed?
      "completed"
    elsif todo.started?
      "started"
    else
      "todo"
    end
  end
end
