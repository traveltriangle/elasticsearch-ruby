module Elasticsearch6
  module XPack
    module API
      module Graph
        module Actions; end

        class GraphClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Graph::Actions
        end

        def graph
          @graph ||= GraphClient.new(self)
        end

      end
    end
  end
end
