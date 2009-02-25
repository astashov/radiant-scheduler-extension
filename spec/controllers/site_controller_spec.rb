require File.dirname(__FILE__) + "/../spec_helper"

describe SiteController do
  before do
    create_pages
  end
  
  it "should not render unpublished children" do
    get :show_page, :url => '/'
    response.should be_success
    [:unexpired, :all_blank, :unexpired_with_blank_start].each do |page|
      response.should have_tag("li", page.to_s.humanize)
    end
    [:unpublished, :unpublished_with_blank_end, :expired, :expired_with_blank_start].each do |page|
      response.should_not have_tag("li", page.to_s.humanize)
    end
  end
end
