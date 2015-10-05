# encoding: utf-8

module Rsolr
  module Rails
    module Instrumentation
      module Runtime
        def self.reset_all
          reset_runtime
          reset_query_count
          reset_query_time
        end

        def self.runtime=(value)
          Thread.current["solr_execute_runtime"] = value
        end

        def self.runtime
          Thread.current["solr_execute_runtime"] ||= 0
        end

        def self.reset_runtime
          rt = runtime
          self.runtime = 0
          rt
        end

        def self.query_count=(value)
          Thread.current["solr_query_count"] = value
        end

        def self.query_count
          Thread.current["solr_query_count"] ||= 0
        end

        def self.reset_query_count
          qc = query_count
          self.query_count = 0
          qc
        end

        def self.query_time=(value)
          Thread.current["solr_query_time"] = value
        end

        def self.query_time
          Thread.current["solr_query_time"] ||= 0
        end

        def self.reset_query_time
          qt = query_time
          self.query_time = 0
          qt
        end
      end
    end
  end
end

