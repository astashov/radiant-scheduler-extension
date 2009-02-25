require File.dirname(__FILE__) + '/../spec_helper'

describe Snippet do
   
  before do
    Snippet.create!(:name => "homepage", :content => "simple")
    Snippet.create!(:name => "expired_with_blank_start", :expires_on => (Date.today-1), :content => "simple")
    Snippet.create!(:name => "unexpired_with_blank_start", :expires_on => (Date.today+1), :content => "simple")
    Snippet.create!(:name => "all_blank", :content => "simple")
    Snippet.create!(:name => "unexpired", :appears_on => (Date.today-1), :expires_on => (Date.today+1), :content => "simple")
    Snippet.create!(:name => "unpublished_with_blank_end", :appears_on => (Date.today+1), :content => "simple")
    Snippet.create!(:name => "unpublished", :appears_on => (Date.today+1), :expires_on => (Date.today+2), :content => "simple")
  end 
  
  it "should respond_to find_by_name_with_scheduling" do
    Snippet.should respond_to(:find_by_name_with_scheduling)
  end
  
  it "should find published records by name" do
    ['homepage', 'unexpired', 'unexpired_with_blank_start', 'all_blank'].each do |snippet|
      founded_snippet = Snippet.find_by_name(snippet)
      founded_snippet.should_not be_nil
      # 'empty' is Snippet with empty content
      founded_snippet.name.should_not == 'empty'
    end
  end
  
  it "should not find unpublished records by name" do
    ['expired_with_blank_start', 'unpublished', 'unpublished_with_blank_end'].each do |snippet|
      founded_snippet = Snippet.find_by_name(snippet)
      founded_snippet.should_not be_nil
      founded_snippet.name.should == 'empty'
    end
  end

end