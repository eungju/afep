class ClosedMark < ActiveRecord::Base
  def self.recent(n)
    find(:all, {:order => "task_id DESC", :limit => n})
  end
  def self.find_completed
    marks = recent(2)
    marks[1] if marks.size == 2
  end
end
