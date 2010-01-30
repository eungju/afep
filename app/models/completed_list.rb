class CompletedList
  def initialize
    @mark = ClosedMark.find_completed
  end
  def find_uncompleted_task
    Task.find_uncompleted_before(@mark) if @mark
  end
end
