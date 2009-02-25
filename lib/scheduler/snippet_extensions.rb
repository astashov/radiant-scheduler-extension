module Scheduler::SnippetExtensions
  include Scheduler::CommonExtensions
  
  def self.included(base)
    base.extend ClassMethods
    class << base
      alias_method_chain :find_by_name, :scheduling
    end
  end

  module ClassMethods
    def find_by_name(name)
      Snippet.find(:first, :conditions => { :name => name })
    end
    
    def find_by_name_with_scheduling(name, live = true)
      if live
        self.with_published_only do
          find_by_name_without_scheduling(name)
        end
      else
        find_by_name_without_scheduling(name)
      end
    end
    
    def with_published_only(&block)
      raise ArgumentError, "Block required!" unless block_given?
      # Let's not duplicate the scope, but also not obliterate any incoming scope
      unless @with_published
        @with_published = true
        results = with_scope(:find => {:conditions => ["((appears_on IS NULL AND expires_on IS NULL) OR (appears_on IS NULL AND ? <= expires_on) OR (expires_on IS NULL AND ? >= appears_on) OR (? BETWEEN appears_on AND expires_on))", Date.today, Date.today, Date.today]}, &block)
        @with_published = false
        # In order that don't override tag 'snippet' for display empty string if snippet doesn't exists,
        # we just send new Snippet object with empty content - it's more simple.
        results || Snippet.new(:name => "empty", :content => "")
      else
        block.call
      end
    end
  end
  
end
