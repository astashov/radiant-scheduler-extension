# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class SchedulerExtension < Radiant::Extension
  version "0.2"
  description "Allows setting of appearance and expiration dates for pages."
  url "http://dev.radiantcms.org"
    
  def activate
    Page.send :include, Scheduler::PageExtensions
    Snippet.send :include, Scheduler::SnippetExtensions
    
    SiteController.send :include, Scheduler::ControllerExtensions
    
    admin.page.edit.add :extended_metadata, "edit_scheduler_meta"
    admin.snippet.edit.add :form, "edit_scheduler_meta", :after => "edit_filter"
  end
  
  def deactivate
  end
  
end
