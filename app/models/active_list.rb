class ActiveList
  def add(subject)
    Task.create!(:subject=>subject, :created_at=>Time.now)
  end
  def close
    last_task = Task.find(:first, :order=>"id DESC", :limit=>1)
    ClosedMark.create!(:task_id=>last_task.id)
  end
end
