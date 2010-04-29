class WorkingList
  def initialize
    @marks = ClosedMark.recent(3)
    if @marks.size == 3
      @tasks = Task.find(:all, :conditions=>["id > ?", @marks[-1].task_id], :order=>"id DESC")
    else
      @tasks = Task.find(:all, :order=>"id DESC")
    end
  end
  def tasks
    @tasks
  end
  def has_closed_list
    @marks.size >= 1
  end
  def closed_mark
    @marks[0]
  end
  def completely_closed_mark
    @marks[1]
  end
  def has_completely_closed_list
    @marks.size >= 2
  end
end

