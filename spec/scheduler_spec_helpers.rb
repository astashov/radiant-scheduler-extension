module SchedulerSpecHelpers
  
  def create_pages
    Page.destroy_all
    pages = {}
    pages[:homepage] = Page.create!(
      :title => "Home", 
      :breadcrumb => "Home", 
      :slug => "/", 
      :status_id => "100",
      :parts => [{
        :filter_id => "Textile", 
        :name => "body", 
        :content => "<ul><r:children:each><li><r:title /></li></r:children:each></ul>"
      }]
    )
    pages[:expired_with_blank_start] = Page.create!(
      :expires_on => (Date.today-1), 
      :title => "Expired with blank start", 
      :breadcrumb => "Expired with blank start", 
      :slug => "expired-with-blank-start", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages[:unexpired_with_blank_start] = Page.create!(
      :expires_on => (Date.today+1), 
      :title => "Unexpired with blank start", 
      :breadcrumb => "Unexpired with blank start", 
      :slug => "unexpired-with-blank-start", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages[:all_blank] = Page.create!(
      :title => "All blank", 
      :breadcrumb => "All blank", 
      :slug => "all-blank", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages[:unexpired] = Page.create!(
      :appears_on => (Date.today-1), 
      :expires_on => (Date.today+1), 
      :title => "Unexpired", 
      :breadcrumb => "Unexpired", 
      :slug => "unexpired", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages[:unpublished_with_blank_end] = Page.create!(
      :appears_on => (Date.today+1), 
      :title => "Unpublished with blank end", 
      :breadcrumb => "Unpublished with blank end", 
      :slug => "unpublished-with-blank-end", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages[:unpublished] = Page.create!(
      :appears_on => (Date.today+1), 
      :expires_on => (Date.today+2), 
      :title => "Unpublished", 
      :breadcrumb => "Unpublished", 
      :slug => "unpublished", 
      :status_id => "100", 
      :parent => pages[:homepage]
    )
    pages
  end
  
end