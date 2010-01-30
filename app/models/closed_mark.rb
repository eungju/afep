class ClosedMark < ActiveRecord::Base
  def self.find_recent_two
    ClosedMark.find(:all, :order=>"task_id DESC", :limit=>2)
  end
  def self.find_completed
    recent_closed_marks = find_recent_two
    recent_closed_marks[1] if recent_closed_marks.size == 2
  end
end
