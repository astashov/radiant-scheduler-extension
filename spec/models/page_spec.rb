require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  
  before do
    @pages = create_pages
  end
  
  it "should scope find_by_url" do
    Page.should respond_to(:find_by_url_with_scheduling)
    [:homepage, :unexpired, :unexpired_with_blank_start, :all_blank].each do |page|
      Page.find_by_url(@pages[page].url).should_not be_nil
    end
    [:expired_with_blank_start, :unpublished, :unpublished_with_blank_end].each do |page|
      Page.find_by_url(@pages[page].url).should be_nil
    end
    # When in 'dev' mode, find all pages, whether expired or not!
    [:homepage, :unexpired, :unexpired_with_blank_start, :all_blank, :expired_with_blank_start, :unpublished, :unpublished_with_blank_end].each do |page|
      Page.find_by_url(@pages[page].url, false).should_not be_nil
    end
  end

  it "should have boolean accessors" do
    [:homepage, :unexpired, :unexpired_with_blank_start, :all_blank].each do |page|
      @pages[page].should be_appeared
      @pages[page].should_not be_expired
      @pages[page].should be_visible
    end
    @pages[:expired_with_blank_start].should be_appeared
    @pages[:expired_with_blank_start].should be_expired
    @pages[:expired_with_blank_start].should_not be_visible
    [:unpublished, :unpublished_with_blank_end].each do |page|
      @pages[page].should_not be_appeared
      @pages[page].should_not be_expired
      @pages[page].should_not be_visible
    end
  end


  it "should have <r:children> scoping" do
    @pages[:homepage].should render(
      '<r:children:each><r:title /> </r:children:each>'
    ).as(
      "All blank Unexpired Unexpired with blank start "
    )
  end
end
