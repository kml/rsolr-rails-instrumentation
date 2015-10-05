# encoding: utf-8

module Rsolr
  module Rails
    module Instrumentation
      class LogSubscriber < ActiveSupport::LogSubscriber
        def query(event)
          request = event.payload[:request]
          response = event.payload[:response].with_indifferent_access

          query_time_ms = response[:responseHeader][:QTime]

          Runtime.runtime += event.duration
          Runtime.query_count += 1
          Runtime.query_time += query_time_ms

          return unless logger.debug?

          method = request[:method]
          uri = request[:uri]
          num_found = response[:response][:numFound]

          debug "SOLR: #{method.to_s.upcase} #{uri} numFound: #{num_found} QTime: #{format_duration(query_time_ms)} QUERY_COUNT: #{Runtime.query_count}"
        end
      end
    end
  end
end

