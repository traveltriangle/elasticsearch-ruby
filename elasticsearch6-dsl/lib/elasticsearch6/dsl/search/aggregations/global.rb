module Elasticsearch6
  module DSL
    module Search
      module Aggregations

        # Defines a single bucket of all the documents matching a query
        #
        # @example
        #
        #     search do
        #       aggregation :all_documents do
        #         global do
        #           aggregation :avg_clicks do
        #             avg field: 'clicks'
        #           end
        #         end
        #       end
        #     end
        #
        # @see https://www.elastic.co/guide/en/elasticsearch6/reference/current/search-aggregations-bucket-global-aggregation.html
        #
        class Global
          include BaseAggregationComponent
        end

      end
    end
  end
end
