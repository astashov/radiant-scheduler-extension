 module Scheduler::PageExtensions
  include Scheduler::CommonExtensions
  include Radiant::Taggable
  
  def self.included(base)
    base.extend ClassMethods
    class << base
      alias_method_chain :find_by_url, :scheduling
    end
  end

  module ClassMethods
    def find_by_url_with_scheduling(url, live=true)
      if live
        self.with_published_only do
          find_by_url_without_scheduling(url, live)
        end
      else
        find_by_url_without_scheduling(url, live)
      end
    end
    
    def with_published_only(&block)
      raise ArgumentError, "Block required!" unless block_given?
      # Let's not duplicate the scope, but also not obliterate any incoming scope
      unless @with_published
        @with_published = true
        results = with_scope(:find => {:conditions => ["((appears_on IS NULL AND expires_on IS NULL) OR (appears_on IS NULL AND ? <= expires_on) OR (expires_on IS NULL AND ? >= appears_on) OR (? BETWEEN appears_on AND expires_on))", Date.today, Date.today, Date.today]}, &block)
        @with_published = false
        results
      else
        block.call
      end
    end
  end
  
  tag 'children' do |tag|
    tag.locals.children = tag.locals.page.children
    Page.with_published_only do
      tag.expand
    end
  end
end
