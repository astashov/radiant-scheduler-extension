module Scheduler::CommonExtensions
  
  def visible?
    published? && appeared? && !expired?
  end
  
  def appeared?
    appears_on.blank? || appears_on <= Date.today
  end
  
  def expired?
    !expires_on.blank? && self.expires_on < Date.today
  end
  
end