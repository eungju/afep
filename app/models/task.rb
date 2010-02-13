class Task < ActiveRecord::Base
  def mark_as_started
    if started? or completed?
      raise "Already started"
    end
    self.started_at = Time.now
  end
  def started?
    self.started_at != nil
  end
  def mark_as_completed
    if not started? or completed?
      raise "Not started or already completed"
    end
    self.completed_at = Time.now
  end
  def completed?
    self.completed_at != nil
  end
  def self.find_uncompleted_before(closed_mark)
    Task.find(:first, :conditions=>["id <= ? and completed_at is null", closed_mark.task_id], :order=>"id", :limit=>1)
  end
end
