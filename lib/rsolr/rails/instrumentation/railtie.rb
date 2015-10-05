# encoding: utf-8

require "rails/railtie"

module Rsolr
  module Rails
    module Instrumentation
      class Railtie < ::Rails::Railtie
        initializer "rsolr.rails.instrumentation" do |app|
          class ::RSolr::Client
            alias execute_without_instrumentation execute

            def execute(request_context)
              ActiveSupport::Notifications.instrument("query.rsolr", request: request_context) do |payload|
                payload[:response] = execute_without_instrumentation(request_context)
              end
            end
          end

          ActiveSupport.on_load(:action_controller) do
            include ControllerRuntime
          end

          LogSubscriber.attach_to :rsolr
        end
      end
    end
  end
end

