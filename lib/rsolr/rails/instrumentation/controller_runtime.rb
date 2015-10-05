# encoding: utf-8

module Rsolr
  module Rails
    module Instrumentation
      module TextHelper
        extend ActionView::Helpers::TextHelper
      end

      module ControllerRuntime
        extend ActiveSupport::Concern

        protected

        attr_internal :solr_runtime
        attr_internal :solr_query_count

        def process_action(action, *args)
          Runtime.reset_all
          super(action, *args)
        end

        def cleanup_view_runtime
          solr_rt_before_render = Runtime.reset_runtime
          solr_qc_before_render = Runtime.reset_query_count
          runtime = super
          solr_rt_after_render = Runtime.reset_runtime
          solr_qc_after_render = Runtime.reset_query_count
          self.solr_runtime = solr_rt_before_render + solr_rt_after_render
          self.solr_query_count = solr_qc_before_render + solr_qc_after_render
          runtime - solr_rt_after_render
        end

        def append_info_to_payload(payload)
          super
          payload[:solr_runtime] = (solr_runtime || 0) + Runtime.reset_runtime
          payload[:solr_query_count] = (solr_query_count || 0) + Runtime.reset_query_count
          payload[:solr_query_time] = Runtime.reset_query_time
        end

        module ClassMethods
          def log_process_action(payload)
            messages = super

            if payload[:solr_runtime]
              messages << "Solr: %.1fms [QTime: %.1fms, %s]" % [
                payload[:solr_runtime].to_f,
                payload[:solr_query_time].to_f,
                TextHelper.pluralize(payload[:solr_query_count], "query")
              ]
            end

            messages
          end
        end
      end
    end
  end
end

