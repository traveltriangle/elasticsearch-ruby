module Elasticsearch6
  module XPack
    module API
      module Rollup
        module Actions; end

        class RollupClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Rollup::Actions
        end

        def rollup
          @rollup ||= RollupClient.new(self)
        end

      end
    end
  end
end
