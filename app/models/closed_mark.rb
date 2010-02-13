class ClosedMark < ActiveRecord::Base
  def self.find_completed
    recent = ClosedMark.find(:all, :order=>"task_id DESC", :limit=>2)
    recent[1] if recent.size == 2
  end
end
