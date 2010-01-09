class Todo < ActiveRecord::Base
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
end
