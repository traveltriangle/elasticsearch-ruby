module Elasticsearch6
  module XPack
    module API
      module Monitoring
        module Actions; end

        class MonitoringClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Monitoring::Actions
        end

        def monitoring
          @monitoring ||= MonitoringClient.new(self)
        end

      end
    end
  end
end
